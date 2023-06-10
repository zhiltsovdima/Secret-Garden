//
//  DataCoder.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 08.06.2023.
//

import Foundation

final class DataCoder {
    
    static func decode<T: Decodable>(
        type: T.Type,
        from data: Data,
        using decoder: JSONDecoder = JSONDecoder()
    ) -> Result<T, DataCodingError> {
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.decodingFailed(error))
        }
    }
    
    static func encode<T: Encodable>(
        _ value: T,
        using encoder: JSONEncoder = JSONEncoder()
    ) -> Result<Data, DataCodingError> {
        
        do {
            let encodedData = try encoder.encode(value)
            return .success(encodedData)
        } catch {
            return .failure(.encodingFailed(error))
        }
    }
}
