//
//  PlantData.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 06.12.2022.
//

import Foundation

struct PlantsData: Codable {
    let items: [PlantData]
}

struct PlantData: Codable {
    
    let latin: String
    let origin: String
    let tempmax: TempMax
    let tempmin: TempMin
    let ideallight: String
    let watering: String
    let insects: [String]
}

struct TempMax: Codable {
    let celsius: Int
}

struct TempMin: Codable {
    let celsius: Int
}
