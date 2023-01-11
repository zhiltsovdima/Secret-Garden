//
//  PlantsIO.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import Foundation

// MARK: - PlantsOutput

protocol PlantsOutput: AnyObject {
    func showAddNewPlant()
    func showPlantDetail(_ plant: Plant)
    func showOptions(_ cell: PlantCell)
}

