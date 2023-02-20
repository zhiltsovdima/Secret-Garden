//
//  FileManagerErrors.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 20.02.2023.
//

import Foundation

enum FileManagerError: Error, Equatable {
    case fileNotFound
    case invalidPath
}
