//
//  Shop.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit

struct ShopItem {
    
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
    var id: Int?
    
}

class Shop {
    
    var items = [ShopItem]()
    
    var favoriteItems = [ShopItem]()
    
    init() {
        fetchData()
    }
    
    var unfavoriteCompletion: ((Int) -> Void)?
    var completion: ((Int) -> Void)?
    
    func unfavorite(withId id: Int) {
        for index in items.indices {
            if items[index].id == id {
                items[index].isFavorite = false
                unfavoriteCompletion?(index)
            }
        }
    }
    
    private func fetchData() {
        
        APIManager.shared.getPost(collectionName: Resources.Strings.Shop.collectionNameInDataBase) { shopItems in
            
            self.items = shopItems
            for index in self.items.indices {
                let imageName = self.items[index].imageString
                APIManager.shared.getImage(imageName: imageName) { fetchedImage in
                    self.items[index].image = fetchedImage
                    self.completion?(index)
                }
                self.items[index].id = index
            }
        }
    }
}
