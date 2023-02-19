//
//  ValidateError.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 19.02.2023.
//

import Foundation

enum ValidateError: Error, Equatable {
    case empty
    case emptyName
    case emptyImage
    
    var description: String {
        switch self {
        case .empty:
            return "Add the data please"
        case .emptyName:
            return "You have to add the plant name"
        case .emptyImage:
            return "You have to add the Image"
        }
    }
}
