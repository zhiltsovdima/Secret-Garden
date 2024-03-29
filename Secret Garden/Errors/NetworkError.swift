//
//  NetworkError.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 24.12.2022.
//

import Foundation

enum NetworkError: Error, Equatable {
    case noInternet
    case timeout(statusCode: Int)
    case authenticationError(statusCode: Int)
    case unavailable(statusCode: Int)
    case tooManyRequests(statusCode: Int)
    case badRequest(statusCode: Int)
    case wrongURL
    case failed
    case noData
    case noDataForThisName
    case serverError(statusCode: Int)
    
    var description: String {
        switch self {
        case .noInternet:
            return "Please, check your network connection"
        case .timeout(let statusCode):
            return "\(statusCode) Timeout"
        case .authenticationError(let statusCode):
            return "\(statusCode) You need to be authenticated first"
        case .unavailable(let statusCode):
            return "\(statusCode) Service unavailable"
        case .tooManyRequests(let statusCode):
            return "\(statusCode) Too many requests. You reached your per minute or per day rate limit"
        case .badRequest(let statusCode):
            return "\(statusCode) Bad request"
        case .wrongURL:
            return "Wrong URL"
        case .failed:
            return "Network request failed"
        case .noData:
            return "Response returned with no data to decode"
        case .noDataForThisName:
            return "There is no data for this plant's name"
        case .serverError(let statusCode):
            return "Server error. Status code: \(statusCode)"
        }
    }
    
    static func processResponseData(_ data: Data?, _ response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.failed
        }
        switch httpResponse.statusCode {
        case 200...299:
            guard let data else { throw NetworkError.noData }
            return data
        case 401, 403:
            throw NetworkError.authenticationError(statusCode: httpResponse.statusCode)
        case 404:
            throw NetworkError.unavailable(statusCode: httpResponse.statusCode)
        case 408:
            throw NetworkError.timeout(statusCode: httpResponse.statusCode)
        case 429:
            throw NetworkError.tooManyRequests(statusCode: httpResponse.statusCode)
        case 400...599:
            throw NetworkError.badRequest(statusCode: httpResponse.statusCode)
        case 503:
            throw NetworkError.unavailable(statusCode: httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw NetworkError.failed
        }
    }
}
