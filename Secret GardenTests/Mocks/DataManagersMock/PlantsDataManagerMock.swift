//
//  PlantsDataManagerMock.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 20.02.2023.
//

import UIKit
@testable import Secret_Garden

final class PlantsDataManagerMock: PlantsDataManagerProtocol {
    
    var plants = [Plant]()
    
    func loadFromFile() -> Result<[Plant], Error> {
        return .success(plants)
    }
    
    func saveToFile(plants: [Plant]) {
        self.plants = plants
    }
    
}
