//
//  WeatherService.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 08.06.2023.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(lat: String, long: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

final class WeatherService {
    
    private let networkManager: NetworkManagerProtocol
        
    init(_ networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - WeatherServiceeProtocol

extension WeatherService: WeatherServiceProtocol {
    
    func getWeather(lat: String, long: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let apiEndpoint = APIEndpoints.weather(lat: lat, long: long)
        networkManager.fetchData(apiEndpoint: apiEndpoint) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                parseWeatherData(data, completion: completion)
            case .failure(let netError):
                completion(.failure(netError))
            }
        }
    }
}

// MARK: - Private Methods

extension WeatherService {
    
    private func parseWeatherData(_ data: Data, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let parseResult = DataCoder.decode(type: WeatherData.self, from: data)
        switch parseResult {
        case .success(let weatherData):
            completion(.success(weatherData))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
