//
//  UIImage + ext.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.11.2022.
//

import UIKit

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpegCompress(_ quality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: quality.rawValue)
    }
}
