//
//  APIEndpoints.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

enum APIEndpoints {
    
    case plants(PlantsOption)
    case weather(String)
    
    enum PlantsOption {
        case common(String)
        case latin(String)
        case all
    }
    
    private var baseURL: String {
        switch self {
        case .plants:
            return "https://house-plants.p.rapidapi.com"
        case .weather:
            return "https://api.openweathermap.org/data/2.5/weather"
        }
    }
    
    private var path: String {
        switch self {
        case .plants(let option):
            switch option {
            case .common(let plant):
                let plantName = plant.lowercased().replacingOccurrences(of: " ", with: "")
                return "/common/\(plantName)"
            case .latin(let plant):
                let plantName = plant.lowercased().replacingOccurrences(of: " ", with: "")
                return "/latin/\(plantName)"
            case .all: return "/all"
            }
        case .weather(let location):
            return location + "&appid=" + PrivateKeys.APIWeatherKey
        }
    }
    
    private var headers: [String: String] {
        switch self {
        case .plants:
            return ["X-RapidAPI-Key": PrivateKeys.APIPlantKey,
                    "X-RapidAPI-Host": "house-plants.p.rapidapi.com"
            ]
        case .weather:
            return ["appid": PrivateKeys.APIWeatherKey]
        }
    }
}

extension APIEndpoints {
    
    func makeURLRequest() -> URLRequest {
        var urlString = baseURL
        urlString.append(path)
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            return request
        } else {
            fatalError("Invalid URL")
        }
    }
}
