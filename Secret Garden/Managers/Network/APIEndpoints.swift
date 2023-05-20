//
//  APIEndpoints.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

enum APIEndpoints {
    
    case news
    case plants(PlantsOption)
    case weather(lat: String, long: String)
    
    enum PlantsOption {
        case common(String)
        case latin(String)
        case all
    }
    
    private var baseURL: String {
        switch self {
        case .news:
            return "https://run.mocky.io"
        case .plants:
            return "https://house-plants.p.rapidapi.com"
        case .weather:
            return "https://api.openweathermap.org/data/2.5/weather"
        }
    }
    
    private var path: String? {
        switch self {
        case .news:
            return "/v3/39efc405-78df-474c-8ddf-f94cf7b02231"
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
        case .weather(let latitude, let longitude):
            let location = "?lat=\(latitude)&lon=\(longitude)"
            return location + "&units=metric" + "&appid=\(PrivateKeys.APIWeatherKey)"
        }
    }
    
    private var headers: [String: String]? {
        switch self {
        case .news:
            return nil
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
        if let path {
            urlString.append(path)
        }
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
