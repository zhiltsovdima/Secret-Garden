//
//  Shop.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 15.11.2022.
//

import UIKit

class Shop {
    
    var items = [ShopItem]()
    
    init() {
        fetchData()
    }
    
    var updateViewCompletion: ((Int, IndexPath?) -> Void)?
    
    func makeFavoriteItem(withId index: Int, at indexPath: IndexPath? = nil) {
        items[index].isFavorite = !items[index].isFavorite
        updateViewCompletion?(index, indexPath)
    }
    
    func makeAddedToCart(withId index: Int, at indexPath: IndexPath? = nil) {
        items[index].isAddedToCart = !items[index].isAddedToCart
        updateViewCompletion?(index, indexPath)
    }
    
    private func fetchData() {
        DBManager.shared.getPost() { [weak self] shopItems in
            self?.items = shopItems
            for index in self!.items.indices {
                self?.items[index].id = index
            }
        }
    }
}
