//
//  HomeViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelProtocol: AnyObject {
    var weather: BehaviorRelay<WeatherModel?> { get }
    var loadingState: BehaviorRelay<LoadingState> { get }
    var news: BehaviorRelay<[ArticleModel]> { get }
    
    func updateWeather()
    func updateNews()
    func gardenButtonTapped()
    func shopButtonTapped()
    func articleSelectRow(at indexPath: IndexPath)
}

// MARK: - HomeViewModel

enum LoadingState {
    case idle
    case loading
    case loaded
    case failed(String)
}

final class HomeViewModel {
    
    var weather = BehaviorRelay<WeatherModel?>(value: nil)
    
    var loadingState = BehaviorRelay<LoadingState>(value: .idle)
    
    var news = BehaviorRelay<[ArticleModel]>(value: [])
        
    private weak var coordinator: HomeCoordinatorProtocol?
    private let locationManager: LocationManager
    private let networkManager: NetworkManagerProtocol

    
    init(_ coordinator: HomeCoordinatorProtocol, _ locationManager: LocationManager, _ networkManager: NetworkManagerProtocol) {
        self.coordinator = coordinator
        self.locationManager = locationManager
        self.networkManager = networkManager
    }
    
    private func fetchImages(for articleIndexes: [Int]? = nil) {
        let indexes = articleIndexes ?? Array(0..<news.value.count)
        let group = DispatchGroup()
        indexes.forEach { index in
            let article = news.value[index]
            guard let imageURL = URL(string: article.imageString) else { return }
            group.enter()
            networkManager.fetchImage(from: imageURL) { result in
                switch result {
                case .success(let image):
                    article.image.accept(image)
                case .failure(let netError):
                    print("Image fetching failure: \(netError.description)")
                    article.image.accept(Resources.Images.Common.failedImage)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.loadingState.accept(.loaded)
        }
    }
}

// MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    
    func updateWeather() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func updateNews() {
        loadingState.accept(.loading)
        networkManager.fetchData(by: .news) { [weak self] (result: Result<[ArticleData], NetworkError>) in
            guard let self else { return }
            switch result {
            case.success(let articles):
                let articleModels = articles.map({ article in
                    ArticleModel(
                        title: article.title,
                        category: article.category,
                        textId: article.textId,
                        imageString: article.imageString,
                        date: article.date
                    )
                })
                self.news.accept(articleModels)
                self.fetchImages()
            case .failure(let netError):
                print("News fetching failure: \(netError.description)")
                self.loadingState.accept(.failed(netError.description))
            }
        }
    }
    
    func gardenButtonTapped() {
        coordinator?.moveToGarden()
    }
    
    func shopButtonTapped() {
        coordinator?.moveToShop()
    }
    
    func articleSelectRow(at indexPath: IndexPath) {
        let article = news.value[indexPath.row]
        coordinator?.showArticleDetail(article)
    }
    
}

extension HomeViewModel: WeatherManagerDelegate {
    
    func didUpdateLocation(place: String, latitude: String, longitude: String) {
        networkManager.fetchData(by: .weather(lat: latitude, long: longitude)) { [weak self] (result: Result<WeatherData, NetworkError>) in
            switch result {
            case .success(let weatherData):
                guard let id = weatherData.weather.first?.id,
                      let description = weatherData.weather.first?.description.capitalized
                else { return }
                let temp = weatherData.main.temp
                let tempMin = weatherData.main.tempMin
                let tempMax = weatherData.main.tempMax
                let weatherModel = WeatherModel(
                    weatherId: id,
                    placeName: place,
                    temperature: temp,
                    tempMin: tempMin,
                    tempMax: tempMax,
                    description: description
                )
                self?.weather.accept(weatherModel)
            case .failure(let netError):
                print(netError.description)
            }
        }
    }
}
