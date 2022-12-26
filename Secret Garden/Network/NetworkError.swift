//
//  NetworkError.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 24.12.2022.
//

import Foundation

enum NetworkError: String, Error {
    
    case noInternet = "Please, check your network connection"
    case timeout = "Timeout"
    case authenticationError = "You need to be authenticated first"
    case unavailable = "Service unavailable"
    case tooManyRequest = "Too many requests. You reached your per minute or per day rate limit"
    case badRequest = "Bad request"
    case wrongURL = "Wrong URL"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "Couldn't decode the response"
    case noDataForThisName = "There is no data for this plant's name"
    case serverError = "Server error"
    
    static func handleNetworkResponse(_ data: Data?, _ response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Self.failed
        }
        switch httpResponse.statusCode {
        case 200...299:
            guard let data else { throw Self.noData }
            return data
        case 401, 403:  throw Self.authenticationError
        case 404:       throw Self.unavailable
        case 408:       throw Self.timeout
        case 429:       throw Self.tooManyRequest
        case 400...599: throw Self.badRequest
        case 503:       throw Self.unavailable
        case 500...599: throw Self.serverError
        default:        throw Self.failed
        }
    }
    
    static func handleError(_ failureError: Error) -> NetworkError {
        switch failureError {
        case is Swift.DecodingError:
            return .unableToDecode
        case let error as URLError where error.code == URLError.Code.badURL:
            return .wrongURL
        case let error as URLError where error.code == URLError.Code.notConnectedToInternet:
            return .noInternet
        case let error as URLError where error.code == URLError.Code.timedOut:
            return .timeout
        case let error as NetworkError:
            return error
        default:
            return .failed
        }
    }
}
