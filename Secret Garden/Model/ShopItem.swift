//
//  ShopItem.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.12.2022.
//

import UIKit

struct ShopItem {
    var id: Int?

    let name: String
    let latinName: String
    let category: String?
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
    
    var isFavorite = false
    var isAddedToCart = false
    
}
