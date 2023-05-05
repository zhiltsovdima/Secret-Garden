//
//  WeatherData.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 05.05.2023.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: WeatherMain
    let cod: Int
    
    var temperature: String {
        return String(format: "%.0f", main.temp)
    }
}

struct Weather: Codable {
    let main: String
}

struct WeatherMain: Codable {
    let temp: Double
}
