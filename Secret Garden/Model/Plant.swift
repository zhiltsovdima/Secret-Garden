//
//  Plant.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 01.11.2022.
//

import UIKit

class Plant: Codable {
    var name: String
    var imageData: PlantImageData
    var features: Features?
    var isFetched = false
    
    init(name: String, image: PlantImageData) {
        self.name = name
        self.imageData = image
    }
    
    func downloadFeatures(completion: ((Features?, String?) -> Void)?) {
        if let features {
            completion?(features, nil)
            return
        }
        guard !isFetched else { completion?(nil, NetworkError.noDataForThisName.rawValue); return }
        NetworkManager.shared.getPlant(by: name) { [weak self] result in
            switch result {
            case .success(let features):
                self?.features = features
                self?.isFetched = true
                completion?(features, nil)
            case .failure(let error):
                if error == NetworkError.noDataForThisName {
                    self?.isFetched = true
                }
                completion?(nil, error.rawValue)
            }
        }
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

struct Features {
    let latinName: String
    let origin: String
    let idealLight: String
    let watering: String
    let insects: [String]
    
    let tempMin: Int
    let tempMax: Int
    
    var temperature: String {
        "From \(tempMin) to \(tempMax)"
    }
}

extension Features: Codable {
    
    enum CodingKeys: String, CodingKey {
        case latinName = "latin"
        case origin
        case idealLight = "ideallight"
        case watering
        case insects
        
        case tempMin = "tempmin"
        case tempMax = "tempmax"
    }
    
    enum TempCodingKeys: String, CodingKey {
        case celsius
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latinName = try container.decode(String.self, forKey: .latinName)
        self.origin = try container.decode(String.self, forKey: .origin)
        self.idealLight = try container.decode(String.self, forKey: .idealLight)
        self.watering = try container.decode(String.self, forKey: .watering)
        self.insects = try container.decode([String].self, forKey: .insects)
        
        //Nested Containers
        let tempContainer = try container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .tempMin)
        let tempMaxContainer = try container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .tempMax)
        self.tempMin = try tempContainer.decode(Int.self, forKey: .celsius)
        self.tempMax = try tempMaxContainer.decode(Int.self, forKey: .celsius)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latinName, forKey: .latinName)
        try container.encode(origin, forKey: .origin)
        try container.encode(idealLight, forKey: .idealLight)
        try container.encode(watering, forKey: .watering)
        try container.encode(insects, forKey: .insects)
        
        var tempMinContainer = container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .tempMin)
        var tempMaxContainer = container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .tempMax)
        try tempMinContainer.encode(tempMin, forKey: .celsius)
        try tempMaxContainer.encode(tempMax, forKey: .celsius)
    }
}
