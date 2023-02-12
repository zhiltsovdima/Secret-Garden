//
//  NetworkProtocols.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void)
}

protocol NetworkManagerDataParser {
    func parseData(_ data: Data) -> Result<Features, NetworkError>
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
