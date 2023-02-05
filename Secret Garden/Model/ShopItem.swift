//
//  ShopItem.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.12.2022.
//

import UIKit

class ShopItem {
    var id: String
    let name: String
    let latinName: String
    let categoryString: String?
    let description: String
    let price: String
    let imageString: String?
    let features: ShopItemFeatures
    
    var image: UIImage?
    var category: ShopCategory? {
        switch categoryString?.lowercased() {
        case Resources.Strings.Shop.Categories.indoor.lowercased():
            return .indoor
        case Resources.Strings.Shop.Categories.outdoor.lowercased():
            return .outdoor
        case Resources.Strings.Shop.Categories.fertilizer.lowercased():
            return .fertilizer
        default:
            return nil
        }
    }
    
    var isFavorite = false
    var isAddedToCart = false
    
    var isDownloading = false
    var callback: ((UIImage?) -> Void)?
    
    init(id: String, name: String, latinName: String, category: String?, description: String, price: String, imageString: String?, features: ShopItemFeatures) {
        self.id = id
        self.name = name
        self.latinName = latinName
        self.categoryString = category
        self.description = description
        self.price = price
        self.imageString = imageString
        self.features = features
    }
}

struct ShopItemFeatures {
    let careLevel: String
    let petFriendly: String
    let size: String
    let light: String
    let humidity: String
    let temperature: String
    let origin: String
}

enum ShopCategory: String {
    case all = "All"
    case indoor = "Indoor"
    case outdoor = "Outdoor"
    case fertilizer = "Fertilizer"
}
