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
}

// MARK: - GardenViewModel

final class HomeViewModel {
    
    var weather: BehaviorRelay<WeatherModel?> = BehaviorRelay(value: nil)
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private let locationManager: LocationManager
    private let networkManager: NetworkManagerProtocol

    
    init(_ coordinator: HomeCoordinatorProtocol, _ locationManager: LocationManager, _ networkManager: NetworkManagerProtocol) {
        self.coordinator = coordinator
        self.locationManager = locationManager
        self.networkManager = networkManager
        
        updateWeather()
    }
    
    private func updateWeather() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

}

// MARK: - GardenViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    
    
}

extension HomeViewModel: WeatherManagerDelegate {
    
    func didUpdateLocation(place: String, latitude: String, longitude: String) {
        networkManager.fetchData(by: .weather(lat: latitude, long: longitude)) { [weak self] (result: Result<WeatherData, NetworkError>) in
            switch result {
            case .success(let weatherData):
                guard let id = weatherData.weather.first?.id,
                      let description = weatherData.weather.first?.description
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
