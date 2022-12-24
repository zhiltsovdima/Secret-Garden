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
        "https://house-plants.p.rapidapi.com/"
    }
    var headers: [String: String] {
        return ["X-RapidAPI-Key": "b05530de65msh6cfb2133d9fa5bdp1b3829jsn681eaacbbab4",
                "X-RapidAPI-Host": "house-plants.p.rapidapi.com"
        ]
    }
    
    var path: String {
        switch self {
        case .common: return "common/"
        case .latin: return "latin/"
        case .all: return "all"
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
    
    func getPlant(by name: String?, completion: @escaping (Result<PlantFeatures, NetworkError>) -> Void) {
        let request = APIType.common.makeRequest(name)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error {
                completion(.failure(NetworkError.handleError(error)))
            }
            guard let response, let data else { return }
            do {
                let safeData = try NetworkError.processResponse(data: data, response: response)
                let result = self.parseData(safeData)
                completion(result)
            } catch {
                completion(.failure(NetworkError.handleError(error)))
            }
        }
        task.resume()
    }
        
    private func parseData(_ data: Data) -> Result<PlantFeatures, NetworkError> {
        do {
            let decodedData = try JSONDecoder().decode([PlantData].self, from: data)
            
            guard decodedData.count > 0 else { return Result.failure(NetworkError.message(reason: "There is no data for this name")) }
            
            let dataForPlant = decodedData.first!
            
            let latin = dataForPlant.latin
            let origin = dataForPlant.origin
            let temp = "From \(dataForPlant.tempmin.celsius)C to \(dataForPlant.tempmax.celsius)C"
            let idealLight = dataForPlant.ideallight
            let watering = dataForPlant.watering
            let insectsArray = dataForPlant.insects
            let insects = insectsArray.joined(separator: ", ")
            
            let features = PlantFeatures(latinName: latin,
                                         values: [
                                            idealLight,
                                            temp,
                                            watering,
                                            insects,
                                            origin
                                         ])
            
            return Result.success(features)
        } catch {
            return Result.failure(NetworkError.handleError(error))
        }
    }
    
    
}
