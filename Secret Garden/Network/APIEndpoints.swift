//
//  APIEndpoints.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

enum APIEndpoints {
    
    case news
    case fullText(String)
    case plants(PlantsOption)
    case weather(lat: String, long: String)
    
    enum PlantsOption {
        case common(String)
        case latin(String)
        case all
    }
    
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        switch self {
        case .news, .fullText:
            return "run.mocky.io"
        case .plants:
            return "house-plants.p.rapidapi.com"
        case .weather:
            return "api.openweathermap.org"
        }
    }
    
    private var path: String {
        switch self {
        case .news:
            return "/v3/ecc49477-d71a-4380-be25-ce5595b07906"
        case .fullText(let urlString):
            return "/v3/\(urlString)"
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
        case .weather:
            return "/data/2.5/weather"
        }
    }
    
    private var parameters: [String: String]? {
        switch self {
        case .weather(let latitude, let longitude):
            return [
                "lat": latitude,
                "lon": longitude,
                "units": "metric",
                "appid": PrivateKeys.APIWeatherKey
            ]
        default:
            return nil
        }
    }
    
    private var headers: [String: String]? {
        switch self {
        case .plants:
            return ["X-RapidAPI-Key": PrivateKeys.APIPlantKey,
                    "X-RapidAPI-Host": "house-plants.p.rapidapi.com"
            ]
        default: return nil
        }
    }
}

// MARK: - Creating URLRequest

extension APIEndpoints {
    
    func makeURLRequest() -> URLRequest {
        let url = URL(scheme: scheme, host: host, path: path, parameters: parameters)
        guard let url else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}
    
