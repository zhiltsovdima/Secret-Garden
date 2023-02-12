//
//  Result + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

extension Result: Equatable where Success: Equatable, Failure: Equatable {
    
    static func == (lhs: Result<Success, Failure>, rhs: Result<Success, Failure>) -> Bool {
        switch (lhs, rhs) {
        case let (.success(lhsValue), .success(rhsValue)):
            return lhsValue == rhsValue
        case let (.failure(lhsError), .failure(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
