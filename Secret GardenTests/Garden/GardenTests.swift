//
//  GardenTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 19.01.2023.
//

import XCTest
@testable import Secret_Garden

final class GardenTests: XCTestCase {
    
    var sut: Garden!
    let networkManager = NetworkManagerMock()
    let plantName = "PlantName"
    let image = UIImage()
    
    override func setUpWithError() throws {
        sut = Garden(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testUpdatePlantNew() throws {
        // Given
        let plant = Plant(name: plantName, image: PlantImageData(image))
        let rowIndex = Int.random(in: 0...100)
        let newPlantName = "NewPlantName"
        sut.plants = [plant]

        // When
        sut.updatePlant(id: plant.id, name: newPlantName, image: UIImage(), at: rowIndex)
        
        // Then
        let updatedName = sut.plants[0].name
        XCTAssertEqual(updatedName, newPlantName, "Expected result to equal NewPlantName, but got \(updatedName) instead")
    }

    func testAddNewPlant() throws {
        sut.addNewPlant(name: plantName, image: image)
        XCTAssertEqual(sut.plants.count, 1)
        XCTAssertEqual(sut.plants[0].name, plantName)
    }
    
    func testRemovePlant() throws {
        // Given
        let plant = Plant(name: plantName, image: PlantImageData(image))
        let rowIndex = Int.random(in: 0...100)
        sut.plants = [plant]
        
        // When
        sut.removePlant(id: plant.id, at: rowIndex)
        
        // Then
        XCTAssertEqual(sut.plants.count, 0)
    }
    
    func testDownloadFeatures_Success() throws {
        // Given
        let plant = Plant(name: plantName, image: PlantImageData(image))
        let expectedFeatures = GetJSONMock.createFeaturesFromJson()
        sut.plants = [plant]
        networkManager.resultToReturn = .success(expectedFeatures)
        let expect = expectation(description: "Download features should succeed")
        
        // When
        sut.downloadFeatures(for: plant) { resultFeatures, networkError in
            // Then
            XCTAssertNotNil(resultFeatures)
            XCTAssertNil(networkError)
            XCTAssertTrue(plant.isFetched)
            XCTAssertEqual(resultFeatures, expectedFeatures)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testDownloadFeatures_Failure_WhenNoDataForThisName() throws {
        // Given
        let plant = Plant(name: plantName, image: PlantImageData(image))
        let expectedError = NetworkError.noDataForThisName
        sut.plants = [plant]
        networkManager.resultToReturn = .failure(expectedError)
        let expect = expectation(description: "Download features should failed")
        
        // When
        sut.downloadFeatures(for: plant) { resultFeatures, networkError in
            // Then
            XCTAssertNil(resultFeatures)
            XCTAssertNotNil(networkError)
            XCTAssertTrue(plant.isFetched)
            XCTAssertEqual(networkError, expectedError)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testDownloadFeatures_Failure_WhenUnableToDecode() throws {
        // Given
        let plant = Plant(name: plantName, image: PlantImageData(image))
        let expectedError = NetworkError.unableToDecode
        sut.plants = [plant]
        networkManager.resultToReturn = .failure(expectedError)
        let expect = expectation(description: "Download features should failed")
        
        // When
        sut.downloadFeatures(for: plant) { resultFeatures, networkError in
            // Then
            XCTAssertNil(resultFeatures)
            XCTAssertNotNil(networkError)
            XCTAssertFalse(plant.isFetched)
            XCTAssertEqual(networkError, expectedError)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
