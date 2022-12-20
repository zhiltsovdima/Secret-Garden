//
//  PlantsData.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 06.12.2022.
//

import Foundation

struct PlantData: Codable {
    let latin: String
    let origin: String
    let tempmax: Temp
    let tempmin: Temp
    let ideallight: String
    let watering: String
    let insects: [String]
}

struct Temp: Codable {
    let celsius: Int
}
