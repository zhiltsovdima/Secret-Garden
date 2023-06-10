//
//  NetworkManager.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 22.12.2022.
//

import UIKit

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

// MARK: - NetworkManager

final class NetworkManager: NetworkManagerProtocol {
    
    private let urlSession: URLSessionProtocol
        
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData(apiEndpoint: APIEndpoints, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = apiEndpoint.makeURLRequest()
        fetchData(request: request, completion: completion)
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = URLRequest(url: url)
        fetchData(request: request, completion: completion)
    }
    
    private func fetchData(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            do {
                let safeData = try NetworkError.processResponseData(data, response)
                completion(.success(safeData))
            } catch {
                let netError = error as! NetworkError
                completion(.failure(netError))
            }
        }
        task.resume()
    }
}
