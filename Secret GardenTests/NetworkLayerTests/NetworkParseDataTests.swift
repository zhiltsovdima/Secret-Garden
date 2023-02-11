//
//  NetworkParseDataTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 11.02.2023.
//

import XCTest
@testable import Secret_Garden

final class NetworkParseDataTests: XCTestCase {
    
    var networkManager: NetworkManagerDataParser!

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testParseData_shouldReturnSuccess() {
        guard let url = Bundle(for: NetworkParseDataTests.self).url(forResource: "FeaturesJsonMock", withExtension: "json") else {
            fatalError("Can't find search.json file")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can't convert json into data")
        }
        
        let result = networkManager.parseData(data)
        
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
        let json = """
        []
        """
        guard let data = json.data(using: .utf8) else { fatalError("Can't convert json into data") }
        
        let result = networkManager.parseData(data)
        
        switch result {
        case .success:
            XCTFail("Parsing should have failed")
        case .failure(let error):
            print(error.description)
            XCTAssertEqual(error, NetworkError.noDataForThisName)
        }
    }
    
    func testParseData_shouldReturnFailure() {
        let json = """
        {
        "test": "not valid json"
        }
        """
        guard let data = json.data(using: .utf8) else { fatalError("Can't convert json into data") }
        
        let result = networkManager.parseData(data)
        
        switch result {
        case .success:
            XCTFail("Parsing should have failed")
        case .failure(let error):
            print(error.description)
            XCTAssertNotNil(error)
        }
    }
}
