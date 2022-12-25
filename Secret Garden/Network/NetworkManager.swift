//
//  NetworkManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.12.2022.
//

import Foundation

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

enum APIType {
    case common
    case latin
    case all
    
    var stringURL: String {
        "https://house-plants.p.rapidapi.com"
    }
    var headers: [String: String] {
        ["X-RapidAPI-Key": "b05530de65msh6cfb2133d9fa5bdp1b3829jsn681eaacbbab4",
         "X-RapidAPI-Host": "house-plants.p.rapidapi.com"
        ]
    }
    
    var path: String {
        switch self {
        case .common: return "/common/"
        case .latin: return "/latin/"
        case .all: return "/all"
        }
    }
    
    func makeRequest(_ plant: String?) -> URLRequest {
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

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void) {
        let request = APIType.common.makeRequest(name)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else { return completion(Result.failure(NetworkError.unknown)) }
            if let error {
                completion(.failure(NetworkError.handleError(error)))
            }
            do {
                let safeData = try NetworkError.processResponse(data: data, response: response)
                let result = self.parseData(safeData)
                completion(result)
            } catch {
                let netError = error as! NetworkError
                completion(.failure(netError))
            }
        }
        task.resume()
    }
        
    private func parseData(_ data: Data) -> Result<Features, NetworkError> {
        do {
            let features = try JSONDecoder().decode([Features].self, from: data)
            guard features.count > 0 else {
                return Result.failure(NetworkError.message(reason: "There is no data for this name"))
            }
            let featuresForPlant = features.first!
            return Result.success(featuresForPlant)
        } catch {
            return Result.failure(NetworkError.handleError(error))
        }
    }
    
    
}
