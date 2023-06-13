//
//  Plant.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

class Plant: Codable {
    var id = UUID().uuidString
    var name: String
    var imageData: PlantImageData
    var features: Features?
    var isFetched = false
        
    init(name: String, image: PlantImageData) {
        self.name = name
        self.imageData = image
    }
}

struct PlantImageData: Codable {
    private let imageData: Data?
    
    var image: UIImage? {
        imageData.map { UIImage(data: $0)! }
    }
    
    init(_ image: UIImage) {
        self.imageData = image.jpegCompress(.low)
    }
}
