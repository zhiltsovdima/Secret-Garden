//
//  Shop.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit

class Shop {
    
    var items = [ShopItem]()
    
    private let dbManager: DBManager
    
    init(dbManager: DBManager) {
        self.dbManager = dbManager
        fetchData()
    }
    
    var updateViewCompletion: ((IndexPath) -> Void)?
    
    func makeFavoriteItem(withId id: Int, at indexPath: IndexPath) {
        items[id].isFavorite = !items[id].isFavorite
        updateViewCompletion?(indexPath)
    }
    
    func makeAddedToCart(withId id: Int, at indexPath: IndexPath) {
        items[id].isAddedToCart = !items[id].isAddedToCart
        updateViewCompletion?(indexPath)
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
