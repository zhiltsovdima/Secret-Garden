//
//  HomeViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.05.2023.
//

import Foundation
import CoreLocation

protocol HomeViewModelProtocol: AnyObject {
    
}

// MARK: - GardenViewModel

final class HomeViewModel {
    
    var temp = ""
    
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
    
    func didUpdateLocation(latitude: String, longitude: String) {
        networkManager.fetchData(by: .weather(lat: latitude, long: longitude)) { [weak self] (result: Result<WeatherData, NetworkError>) in
            switch result {
            case .success(let weatherData):
                self?.temp = weatherData.temperature
            case .failure(let netError):
                print(netError.description)
            }
        }
    }
}
