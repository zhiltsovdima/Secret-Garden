//
//  Shop.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit

class Shop {
    
    var items = [ShopItem]()
    
    var favorites = [ShopItem]()
    
    var cart = [ShopItem]()
    
    init() {
        fetchData()
    }
    
    var updateViewCompletion: ((Int) -> Void)?
    
    func makeFavoriteItem(withId index: Int, to isFavorite: Bool) {
        items[index].isFavorite = isFavorite
        if isFavorite {
            favorites.insert(items[index], at: 0)
        } else {
            favorites.removeAll { item in
                item.id == index
            }
        }
        updateViewCompletion?(index)
    }
    
    func makeAddedToCart(withId index: Int, to isAdded: Bool) {
        items[index].isAddedToCart = isAdded
        if isAdded {
            cart.insert(items[index], at: 0)
        } else {
            cart.removeAll { item in
                item.id == index
            }
        }
        updateViewCompletion?(index)
    }
    
    private func fetchData() {
        APIManager.shared.getPost(collectionName: Resources.Strings.Shop.collectionNameInDataBase) { shopItems in
            
            self.items = shopItems
            for index in self.items.indices {
                let imageName = self.items[index].imageString
                APIManager.shared.getImage(name: imageName) { fetchedImage in
                    self.items[index].image = fetchedImage
                    self.updateViewCompletion?(index)
                }
                self.items[index].id = index
            }
        }
    }
}
