//
//  URLComponents + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.06.2023.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
