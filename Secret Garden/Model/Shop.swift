//
//  Shop.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit

struct ShopItem {
    
    let name: String
    let category: String?
    let description: String?
    let price: Int?
    let imageString: String?
    var image: UIImage?
    
}

class Shop {
    
    var items = [ShopItem]()
    
    private func fetchData() {
        
        APIManager.shared.getPost(collectionName: Resources.Strings.Shop.collectionNameInDataBase) { shopItems in
            
            self.items = shopItems
            for index in self.items.indices {
                let imageName = self.items[index].imageString
                APIManager.shared.getImage(imageName: imageName) { fetchedImage in
                    self.items[index].image = fetchedImage
                }
            }
        }
    }
    
    init() {
        fetchData()
    }
    
}
