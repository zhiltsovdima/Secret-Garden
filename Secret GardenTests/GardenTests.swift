//
//  GardenTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 19.01.2023.
//

import XCTest
@testable import Secret_Garden

final class GardenTests: XCTestCase {
    
    var garden: Garden!
    var plantName = "Foo"
    var image = Resources.Images.Common.defaultPlant!
    
    override func setUpWithError() throws {
        let networkManager = MockNetworkManager()
        garden = Garden(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        garden = nil
    }

    func testAddNewPlant() throws {
        garden.addNewPlant(name: plantName, image: image)
        XCTAssertFalse(garden.plants.isEmpty)
        XCTAssertEqual(garden.plants[0].name, plantName)
    }
    
    func testRemovePlant() throws {
        garden.addNewPlant(name: plantName, image: image)
        XCTAssertFalse(garden.plants.isEmpty)
        garden.removePlant(at: 0)
        XCTAssertTrue(garden.plants.isEmpty)
    }

    func testUpdatePlant() throws {
        let rowInt = 0
        garden.addNewPlant(name: plantName, image: image)
        XCTAssertEqual(garden.plants[rowInt].name, plantName)
        
        let newName = "Bar"
        garden.updatePlant(name: newName, image: image, rowInt)
        XCTAssertEqual(garden.plants[rowInt].name, newName)
    }
    
    func testDownloadFeaturesFailed() throws {
        let failure = "Failure"
        garden.addNewPlant(name: failure, image: image)
        let plant = garden.plants[0]
        var error: String?
        let errorExpectation = expectation(description: "Expectation in " + #function)
        
        garden.downloadFeatures(for: plant) { features, errorMessage in
            guard let errorMessage else { return }
            error = errorMessage
            errorExpectation.fulfill()
        }
        wait(for: [errorExpectation], timeout: 1.0)
        XCTAssertNotNil(error)
    }

}
