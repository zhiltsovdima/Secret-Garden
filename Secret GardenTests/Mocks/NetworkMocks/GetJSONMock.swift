//
//  GetJSONMock.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 16.01.2023.
//

import UIKit
@testable import Secret_Garden

class GetJSONMock {
    
    static let fileName = "FeaturesJsonMock"
        
    static func getDataFromJsonFile() -> Data {
        guard let url = Bundle(for: NetworkParseDataTests.self).url(forResource: fileName, withExtension: "json") else {
            fatalError("Couldn't find \(fileName).json file")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't convert json into data")
        }
        return data
    }
    
    static func createFeaturesFromJson() -> Features {
        let data = getDataFromJsonFile()
        guard let features = try? JSONDecoder().decode([Features].self, from: data) else { fatalError("Couldn't decode jsonData") }
        return features.first!
    }
}
