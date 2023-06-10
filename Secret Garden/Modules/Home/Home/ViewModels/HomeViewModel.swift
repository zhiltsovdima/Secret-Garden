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
    var weather: BehaviorRelay<WeatherViewModel?> { get }
    var loadingState: BehaviorRelay<LoadingState> { get }
    var news: BehaviorRelay<[ArticleViewModelProtocol]> { get }
    
    func updateWeather()
    func updateNews()
    func updateImage(for index: IndexPath)
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
    
    var weather = BehaviorRelay<WeatherViewModel?>(value: nil)
    
    var loadingState = BehaviorRelay<LoadingState>(value: .idle)
    
    var news = BehaviorRelay<[ArticleViewModelProtocol]>(value: [])
        
    private weak var coordinator: HomeCoordinatorProtocol?
    private let locationManager: LocationManager
    private let weatherService: WeatherServiceProtocol
    private let newsService: NewsServiceProtocol

    
    init(_ coordinator: HomeCoordinatorProtocol,
         _ locationManager: LocationManager,
         _ weatherService: WeatherServiceProtocol,
         _ newsService: NewsServiceProtocol)
    {
        self.coordinator = coordinator
        self.locationManager = locationManager
        self.weatherService = weatherService
        self.newsService = newsService
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
        newsService.getNews { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let articles):
                newsFetchingSuccess(articles)
            case .failure(let error):
                newsFetchingFailure(error)
            }
        }
    }
    
    func updateImage(for index: IndexPath) {
        let model = news.value[index.row]
        model.getImage()
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

// MARK: - Handling fetching result

extension HomeViewModel {
    private func newsFetchingSuccess(_ articles: [ArticleData]) {
        let articleModels = articles.map({ article in
            ArticleViewModel(
                self.newsService,
                title: article.title,
                category: article.category,
                textId: article.textId,
                imageString: article.imageString,
                date: article.date
            )
        })
        news.accept(articleModels)
        loadingState.accept(.loaded)
    }
    
    private func newsFetchingFailure(_ error: Error) {
        switch error {
        case let networkError as NetworkError:
            loadingState.accept(.failed(networkError.description))
        case let codingError as DataCodingError:
            loadingState.accept(.failed(codingError.description))
        default:
            loadingState.accept(.failed(error.localizedDescription))
        }
    }
}

// MARK: - WeatherManagerDelegate

extension HomeViewModel: WeatherManagerDelegate {
    
    func didUpdateLocation(place: String, latitude: String, longitude: String) {
        weatherService.getWeather(lat: latitude, long: longitude) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let weatherDataModel):
                guard let id = weatherDataModel.weather.first?.id,
                      let description = weatherDataModel.weather.first?.description.capitalized
                else { return }
                let temp = weatherDataModel.main.temp
                let tempMin = weatherDataModel.main.tempMin
                let tempMax = weatherDataModel.main.tempMax
                let weatherModel = WeatherViewModel(
                    type: WeatherType(weatherId: id),
                    placeName: place,
                    temperature: temp,
                    tempMin: tempMin,
                    tempMax: tempMax,
                    description: description
                )
                weather.accept(weatherModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
