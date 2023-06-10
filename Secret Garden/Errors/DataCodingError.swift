//
//  DataCodingError.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.06.2023.
//

import Foundation

enum DataCodingError: Error {
    case decodingFailed(Error? = nil)
    case encodingFailed(Error?)
    
    var description: String {
        switch self {
        case .decodingFailed(let error):
            return "Failed to decode data: \(error?.localizedDescription ?? "")"
        case .encodingFailed(let error):
            return "Failed to encode: \(error?.localizedDescription ?? "")"
        }
    }
}
