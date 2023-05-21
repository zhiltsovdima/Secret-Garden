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
}

// MARK: - GardenViewModel

enum LoadingState {
    case idle
    case loading
    case loaded
    case failed(NetworkError)
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
                    print(netError.description)
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

// MARK: - GardenViewModelProtocol

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
                print(netError.description)
                self.loadingState.accept(.failed(netError))
            }
        }
    }
    
    func gardenButtonTapped() {
        coordinator?.moveToGarden()
    }
    
    func shopButtonTapped() {
        coordinator?.moveToShop()
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

final class ArticleModel {
    let title: String
    let category: String
    let textId: String
    let imageString: String
    let date: String
    
    var image = BehaviorRelay<UIImage?>(value: nil)
    var fullText: String?
        
    init(title: String, category: String, textId: String, imageString: String, date: String) {
        self.title = title
        self.category = category
        self.textId = textId
        self.imageString = imageString
        self.date = date
    }
}

struct WeatherModel {
    let weatherId: Int
    let placeName: String
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    let description: String
    
    var temperatureString: String {
        return String(format: "%.0f\(Resources.Strings.degreeSymbol)C", temperature)
    }
    
    var tempMinMaxString: String {
        let tempMinStr = String(format: "%.0f\(Resources.Strings.degreeSymbol)C", tempMin)
        let tempMaxStr = String(format: "%.0f\(Resources.Strings.degreeSymbol)C", tempMax)
        return "H: \(tempMaxStr) L: \(tempMinStr)"
    }
    
    var weatherImage: UIImage? {
        switch weatherId {
        case 200...232:
            return Resources.Images.Weather.storm
        case 300...321:
            return Resources.Images.Weather.partyRain
        case 500...502:
            return Resources.Images.Weather.partyRain
        case 503, 504, 521...531:
            return Resources.Images.Weather.rainfall
        case 514...520:
            return Resources.Images.Weather.rain
        case 600...622:
            return Resources.Images.Weather.snow
        case 701...781:
            return Resources.Images.Weather.windy
        case 800:
            return Resources.Images.Weather.sun
        case 801:
            return Resources.Images.Weather.partyCloudy
        case 802...804:
            return Resources.Images.Weather.clouds
        default:
            return Resources.Images.Weather.clouds
        }
    }
}
