//
//  NetworkManagerMock.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation
@testable import Secret_Garden

protocol ResultSetable {
    var resultToReturn: Result<Features, NetworkError>! { get set }
}

class NetworkManagerMock: NetworkManagerProtocol {
    
    var resultToReturn: Result<Features, NetworkError>!
    
    func getPlant(by name: String?, completion: @escaping (Result<Features, NetworkError>) -> Void) {
        completion(resultToReturn)
    }
}

extension NetworkManagerMock: ResultSetable { }
