//
//  PlantsIO.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 09.01.2023.
//

import Foundation

// MARK: - GardenOutput

protocol GardenOutput: AnyObject {
    func showAddNewPlant()
    func showPlantDetail(_ index: Int)
    func showOptions(_ cell: PlantCell)
}
