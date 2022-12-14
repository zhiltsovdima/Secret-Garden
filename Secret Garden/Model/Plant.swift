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
    var latinName: String
    var dictionary: [String: String]
    
    func getArrayOfKeys() -> [String] {
        return [Resources.Strings.Common.Detail.light,
                Resources.Strings.Common.Detail.temperature,
                Resources.Strings.Common.Detail.watering,
                Resources.Strings.Common.Detail.insects,
                Resources.Strings.Common.Detail.origin
        ]
    }
    
    func getArrayOfValues() -> [String] {
        return [dictionary[Resources.Strings.Common.Detail.light]!,
                dictionary[Resources.Strings.Common.Detail.temperature]!,
                dictionary[Resources.Strings.Common.Detail.watering]!,
                dictionary[Resources.Strings.Common.Detail.insects]!,
                dictionary[Resources.Strings.Common.Detail.origin]!
        ]
    }
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
