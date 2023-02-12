//
//  APIEndpoints.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

enum APIEndpoints {
    case common
    case latin
    case all
    
    private var stringURL: String {
        "https://house-plants.p.rapidapi.com"
    }
    private var headers: [String: String] {
        ["X-RapidAPI-Key": PrivateKeys.APIPlantKey,
         "X-RapidAPI-Host": "house-plants.p.rapidapi.com"
        ]
    }
    
    private var path: String {
        switch self {
        case .common: return "/common/"
        case .latin: return "/latin/"
        case .all: return "/all"
        }
    }
}

extension APIEndpoints {
    
    func makeURLRequest(_ plant: String?) -> URLRequest {
        var fullPath = path
        if let plant {
            fullPath.append(plant.lowercased().replacingOccurrences(of: " ", with: ""))
        }
        let url = URL(string: fullPath, relativeTo: URL(string: stringURL))
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}
