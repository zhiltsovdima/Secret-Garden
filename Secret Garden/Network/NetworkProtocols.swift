//
//  NetworkProtocols.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import UIKit

protocol NetworkManagerProtocol {
    func fetchData(apiEndpoint: APIEndpoints, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
