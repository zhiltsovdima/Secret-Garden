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
    
    var characteristics: PlantCharacteristics?
    
    init(name: String, image: PlantImage) {
        self.name = name
        self.image = image
    }
}

struct PlantCharacteristics: Codable {
    var latinName: String?
    var origin: String?
    var temperature: String?
    var idealLight: String?
    var watering: String?
    var insects: String?
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
        self.imageData = image.jpegCompress(.low)
    }
}
