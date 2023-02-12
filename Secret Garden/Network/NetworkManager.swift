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

// MARK: - NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void) {
        let request = APIEndpoints.common.makeURLRequest(name)
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else { return completion(Result.failure(NetworkError.failed))}
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
}

extension NetworkManager: NetworkManagerDataParser {
        
    func parseData(_ data: Data) -> Result<Features, NetworkError> {
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
