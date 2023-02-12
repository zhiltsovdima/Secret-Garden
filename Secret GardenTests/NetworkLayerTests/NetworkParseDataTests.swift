//
//  NetworkParseDataTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 11.02.2023.
//

import XCTest
@testable import Secret_Garden

final class NetworkParseDataTests: XCTestCase {
    
    var sut: NetworkManagerDataParser!

    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testParseData_shouldReturnSuccess() {
        // Given
        guard let url = Bundle(for: NetworkParseDataTests.self).url(forResource: "FeaturesJsonMock", withExtension: "json") else {
            fatalError("Can't find a json file")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can't convert json into data")
        }
        
        // When
        let result = sut.parseData(data)
        
        // Then
        switch result {
        case .success(let features):
            XCTAssertEqual(features.latinName, "Codiaeum petra")
            XCTAssertEqual(features.idealLight, "6 or more hours of direct sunlight per day.")
            XCTAssertEqual(features.watering, "Keep moist between watering. Water when soil is half dry.")
            XCTAssertEqual(features.origin, "Cultivar")
            XCTAssertEqual(features.insects, ["Spider mite",
                                              "Mealy bug"])
        case .failure:
            XCTFail("Parsing should have been successful")
        }
    }
    
    func testParseData_shouldReturnFailure_NoDataForThisName() {
        // Given
        let json = """
        []
        """
        guard let data = json.data(using: .utf8) else { fatalError("Can't convert json into data") }
        
        // When
        let result = sut.parseData(data)
        
        // Then
        switch result {
        case .success:
            XCTFail("Parsing should have failed")
        case .failure(let error):
            XCTAssertEqual(error, NetworkError.noDataForThisName)
        }
    }
    
    func testParseData_shouldReturnFailure() {
        // Given
        let json = """
        {
        "test": "not valid json"
        }
        """
        guard let data = json.data(using: .utf8) else { fatalError("Can't convert json into data") }
        
        // When
        let result = sut.parseData(data)
        
        // Then
        switch result {
        case .success:
            XCTFail("Parsing should have failed")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
}
