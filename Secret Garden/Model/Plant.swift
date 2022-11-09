//
//  Plant.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

struct Plant: Codable {
    var name: String
    var image: PlantImage
}

struct PlantImage: Codable {
    let imageData: Data?
    
    func getImage() -> UIImage? {
        if let imageData {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    init(_ image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.5)
    }
}
