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
    case all
}

class Shop {
    
    var items = [ShopItem]()
    
    private let fbManager: FBManagerProtocol
    
    init(fbManager: FBManagerProtocol) {
        self.fbManager = fbManager
        fetchData()
    }
    
    var updateViewCompletion: ((String, UpdateProperty) -> Void)?
    var updateDetailViewCompletion: ((UpdateProperty) -> Void)?
    
    func makeFavoriteItem(withId id: String) {
        guard let item = items.first(where: { $0.id == id }) else { return }
        item.isFavorite = !item.isFavorite
        updateViewCompletion?(id, .favorite(item.isFavorite))
        updateDetailViewCompletion?(.favorite(item.isFavorite))
    }
    
    func makeAddedToCart(withId id: String) {
        guard let item = items.first(where: { $0.id == id }) else { return }
        item.isAddedToCart = !item.isAddedToCart
        updateViewCompletion?(id, .cart(item.isAddedToCart))
        updateDetailViewCompletion?(.cart(item.isAddedToCart))
    }
    
    private func fetchData() {
        fbManager.getPost() { [weak self] shopItems in
            self?.items = shopItems
        }
    }
    
    func downloadData(for shopItem: ShopItem, completion: ((UIImage?) -> Void)?) {
        guard let imageString = shopItem.imageString else { completion?(Resources.Images.Common.defaultPlant); return }
        fbManager.getImage(name: imageString) { fetchedImage in
            shopItem.image = fetchedImage
            completion?(shopItem.image)
        }
    }
}
