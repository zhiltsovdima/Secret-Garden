//
//  URLSessionMock.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 12.02.2023.
//

import Foundation

class URLSessionMock: URLSession {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let completion: () -> Void
    
    // FIXME: Find a solution of warning
    // 'init()' was deprecated in iOS 13.0:
    // Please use -[NSURLSession dataTaskWithRequest:] or other NSURLSession methods to create instances
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        completion()
    }
}
