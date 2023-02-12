//
//  MockHTTPURLResponse.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

class MockHTTPURLResponse: HTTPURLResponse {
    
    init(statusCode: Int) {
        super.init(url: URL(string: "http://mock.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
