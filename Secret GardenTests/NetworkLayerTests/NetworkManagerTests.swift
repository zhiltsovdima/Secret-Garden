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
    var mockURLSession: URLSessionMock!
    
    override func setUpWithError() throws {
        mockURLSession = URLSessionMock()
        sut = NetworkManager(urlSession: mockURLSession)
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        sut = nil
    }
    
    

    func testGetPlant_ReturnsFeatures_WhenResponseIsSuccessful() throws {
        // Given
        let features = GetJSONMock.createFeaturesFromJson()
        
        mockURLSession.data = GetJSONMock.getDataFromJsonFile()
        mockURLSession.response = HTTPURLResponseMock(statusCode: 200)
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
        mockURLSession.response = HTTPURLResponseMock(statusCode: 404)
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
