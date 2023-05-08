//
//  WeatherData.swift
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
}

struct Main: Codable {
    let temp: Double
}
