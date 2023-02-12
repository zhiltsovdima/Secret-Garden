//
//  NetworkManagerTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import XCTest
@testable import Secret_Garden

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManagerProtocol!
    var mockURLSession: MockURLSession!
    let fileNameJsonMock = "FeaturesJsonMock"
    
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        sut = NetworkManager(urlSession: mockURLSession)
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        sut = nil
    }
    
    func getDataFromJsonFile(fileName: String) -> Data {
        guard let url = Bundle(for: NetworkParseDataTests.self).url(forResource: fileName, withExtension: "json") else {
            fatalError("Can't find \(fileName).json file")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can't convert json into data")
        }
        return data
    }
    
    func createFeaturesFromJson(fileName: String) -> Features {
        let data = getDataFromJsonFile(fileName: fileName)
        guard let features = try? JSONDecoder().decode([Features].self, from: data) else { fatalError("Can't decode jsonData") }
        return features.first!
    }

    func testGetPlant_ReturnsFeatures_WhenResponseIsSuccessful() throws {
        // Given
        let features = createFeaturesFromJson(fileName: fileNameJsonMock)
        
        mockURLSession.data = getDataFromJsonFile(fileName: fileNameJsonMock)
        mockURLSession.response = MockHTTPURLResponse(statusCode: 200)
        mockURLSession.error = nil
        
        let plantName = "TestName"
        let expextedResult: Result<Features, NetworkError> = .success(features)
        let expect = expectation(description: "Wait for the features")
        
        // When
        sut.getPlant(by: plantName) { result in
            // Then
            XCTAssertEqual(expextedResult, result, "Expected result to equal .success(features), but got \(result) instead")
            expect.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testGetPlant_ReturnsUnavailableError_WhenResponseStatusCodeIs404() throws {
        // Given
        mockURLSession.data = nil
        mockURLSession.response = MockHTTPURLResponse(statusCode: 404)
        mockURLSession.error = nil
        
        let plantName = "TestName"
        let expextedResult: Result<Features, NetworkError> = .failure(NetworkError.unavailable(statusCode: 404))
        let expect = expectation(description: "Wait for the result")
        
        // When
        sut.getPlant(by: plantName) { result in
            // Then
            XCTAssertEqual(expextedResult, result, "Expected result to equal .failure(NetworkError.unavailable(statusCode: 404), but got \(result) instead")
            expect.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testGetPlant_ReturnsError_WhenNoInternetConnection() throws {
        // Given
        mockURLSession.data = nil
        mockURLSession.response = nil
        mockURLSession.error = URLError(.notConnectedToInternet)
        
        let plantName = "TestName"
        let expextedResult: Result<Features, NetworkError> = .failure(NetworkError.noInternet)
        let expect = expectation(description: "Wait for the result")
        
        // When
        sut.getPlant(by: plantName) { result in
            // Then
            XCTAssertEqual(expextedResult, result, "Expected result to equal .failure(NetworkError.noInternet, but got \(result) instead")
            expect.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
}
