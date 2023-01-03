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
    
    fileprivate func makeRequest(_ plant: String?) -> URLRequest {
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

protocol NetworkManagerProtocol {
    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
        
    static let shared = NetworkManager()

    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void) {
        let request = APIType.common.makeRequest(name)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else { return completion(Result.failure(NetworkError.failed))}
            guard error == nil else {
                completion(.failure(NetworkError.handleError(error!)))
                return
            }
            do {
                let safeData = try NetworkError.handleNetworkResponse(data, response)
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
                return Result.failure(NetworkError.noDataForThisName)
            }
            let featuresForPlant = features.first!
            return Result.success(featuresForPlant)
        } catch {
            return Result.failure(NetworkError.handleError(error))
        }
    }
    
    
}
