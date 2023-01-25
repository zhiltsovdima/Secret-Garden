//
//  GardenViewModelTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 16.01.2023.
//

import XCTest
@testable import Secret_Garden

final class GardenViewModelTests: XCTestCase {
    
    let navigationController = MockNavigationController()
    var coordinator: GardenCoordinatorProtocol!
    var gardenViewModel: GardenViewModelProtocol!
    var garden = MockGarden()
    var rowInt = 0
    
    override func setUpWithError() throws {
        coordinator = GardenCoordinator(navigationController)
        gardenViewModel = GardenViewModel(coordinator: coordinator, garden: garden)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        gardenViewModel = nil
    }

    func testUpdateModel() throws {
        XCTAssertFalse(gardenViewModel.tableData.isEmpty)
        XCTAssertEqual(gardenViewModel.tableData.count, garden.plants.count)
        XCTAssertTrue(gardenViewModel.tableData[0].plantTitle == "Baz")
    }

    func testAddNewPlantTapped() throws {
        gardenViewModel.addNewPlantTapped()
        let addNewPlantVC = navigationController.presentedVC
        XCTAssertTrue(addNewPlantVC is AddPlantController)
    }
    
    func testRowTapped() throws {
        gardenViewModel.rowTapped(rowInt)
        let detailPlantVC = navigationController.presentedVC
        XCTAssertTrue(detailPlantVC is DetailPlantController)
    }

}
