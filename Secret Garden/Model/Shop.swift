//
//  Shop.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit

enum UpdateProperty {
    case favorite(Bool)
    case cart(Bool)
}

class Shop {
    
    var items = [ShopItem]()
    
    private let dbManager: DBManager
    
    init(dbManager: DBManager) {
        self.dbManager = dbManager
        fetchData()
    }
    
    var updateViewCompletion: ((Int, UpdateProperty) -> Void)?
    
    func makeFavoriteItem(withId id: Int) {
        items[id].isFavorite = !items[id].isFavorite
        let isFavorite = items[id].isFavorite
        updateViewCompletion?(id, .favorite(isFavorite))
    }
    
    func makeAddedToCart(withId id: Int) {
        items[id].isAddedToCart = !items[id].isAddedToCart
        let isAddedToCart = items[id].isAddedToCart
        updateViewCompletion?(id, .cart(isAddedToCart))
    }
    
    private func fetchData() {
        dbManager.getPost() { [weak self] shopItems in
            self?.items = shopItems
            for index in self!.items.indices {
                self?.items[index].id = index
            }
        }
    }
    
    func downloadData(for shopItem: ShopItem, completion: ((UIImage?) -> Void)?) {
        if shopItem.image != nil {
            return
        }

        shopItem.isDownloading = true
        
        guard let imageString = shopItem.imageString else { return }
        dbManager.getImage(name: imageString) { fetchedImage in
            shopItem.image = fetchedImage
            completion?(shopItem.image)
        }
    }
}
