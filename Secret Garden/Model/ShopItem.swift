//
//  ShopItem.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.12.2022.
//

import UIKit

class ShopItem {
    var id: Int?

    let name: String?
    let latinName: String?
    let categoryString: String?
    let description: String?
    let price: String?
    let size: String?
    let petFriendly: String?
    let careLevel: String?
    let origin: String?
    let light: String?
    let humidity: String?
    let temperature: String?
    let imageString: String?
    
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
    
    init(name: String?, latinName: String?, category: String?, description: String?, price: String?, size: String?, petFriendly: String?, careLevel: String?, origin: String?, light: String?, humidity: String?, temperature: String?, imageString: String?) {
        self.name = name
        self.latinName = latinName
        self.categoryString = category
        self.description = description
        self.price = price
        self.size = size
        self.petFriendly = petFriendly
        self.careLevel = careLevel
        self.origin = origin
        self.light = light
        self.humidity = humidity
        self.temperature = temperature
        self.imageString = imageString
    }
}

enum ShopCategory: String {
    case all = "All"
    case indoor = "Indoor"
    case outdoor = "Outdoor"
    case fertilizer = "Fertilizer"
}
