//
//  WeatherDataModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.05.2023.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let cod: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let tempMax: Double
    let tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
    }
}
