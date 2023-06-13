//
//  Features.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 12.06.2023.
//

import Foundation

struct Features: Equatable {
    let latinName: String
    let origin: String
    let idealLight: String
    let watering: String
    let insects: [String]
    
    private let tempMin: Int
    private let tempMax: Int
    
    var temperature: String {
        "From \(tempMin) to \(tempMax)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latinName = try container.decode(String.self, forKey: .latinName)
        self.origin = try container.decode(String.self, forKey: .origin)
        self.idealLight = try container.decode(String.self, forKey: .idealLight)
        self.watering = try container.decode(String.self, forKey: .watering)
        self.insects = try container.decode([String].self, forKey: .insects)
        
        //Nested Containers
        let tempMinContainer = try container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .tempMin)
        let tempMaxContainer = try container.nestedContainer(keyedBy: TempCodingKeys.self, forKey: .tempMax)
        self.tempMin = try tempMinContainer.decode(Int.self, forKey: .celsius)
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

// MARK: - CodingKeys

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
}
