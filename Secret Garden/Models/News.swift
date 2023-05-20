//
//  News.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 19.05.2023.
//

import Foundation

struct News: Codable {
    let title: String
    let category: String
    let textId: String
    let imageString: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case category
        case textId = "text_id"
        case imageString = "image"
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decode(String.self, forKey: .category)
        self.textId = try container.decode(String.self, forKey: .textId)
        self.imageString = try container.decode(String.self, forKey: .imageString)
        self.date = try container.decode(String.self, forKey: .date)
    }
}
