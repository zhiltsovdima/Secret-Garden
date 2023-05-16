//
//  ItemDetailViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import UIKit.UIImage

protocol ItemDetailViewModelProtocol: AnyObject {
    
    var image: UIImage? { get }
    var name: String { get }
    var latinName: String { get }
    var description: String { get }
    var featuresData: ShopItemFeatures? { get }
    var price: String { get }
    
    var isFavorite: Bool { get }
    var isAddedToCart: Bool { get }

    var updateViewCompletion: ((UpdateProperty) -> Void)? { get set }
    
    func favoriteButtonTapped()
    func cartButtonTapped()
    func viewWillAppear()
    func viewWillDisappear()
}

// MARK: - ItemDetailViewModel

final class ItemDetailViewModel {
    
    var image: UIImage?
    var name: String = ""
    var latinName: String = ""
    var description: String = ""
    var featuresData: ShopItemFeatures?
    var price: String = ""
    
    var isFavorite = false
    var isAddedToCart = false
    
    var updateViewCompletion: ((UpdateProperty) -> Void)?

    
    private weak var coordinator: ItemDetailCoordinatorProtocol?
    private let shop: Shop
    private let id: String
        
    init(coordinator: ItemDetailCoordinatorProtocol, shop: Shop, id: String) {
        self.coordinator = coordinator
        self.shop = shop
        self.id = id
        getDataFromModel(for: id)
    }
    
    private func setUpdate() {
        shop.updateDetailViewCompletion = { [weak self] updatedProperty in
            switch updatedProperty {
            case .favorite(let boolValue):
                self?.isFavorite = boolValue
            case .cart(let boolValue):
                self?.isAddedToCart = boolValue
            default: break
            }
            self?.updateViewCompletion?(updatedProperty)
        }
    }
    
    private func getDataFromModel(for id: String) {
        guard let item = shop.items.first(where: { $0.id == id }) else { return }
        image = item.image
        name = item.name
        latinName = item.latinName
        description = item.description
        featuresData = item.features
        price = item.price
        
        isFavorite = item.isFavorite
        isAddedToCart = item.isAddedToCart
    }
    
}

// MARK: - ItemDetailViewModelProtocol

extension ItemDetailViewModel: ItemDetailViewModelProtocol {
    
    func favoriteButtonTapped() {
        shop.makeFavoriteItem(withId: id)
    }
    
    func cartButtonTapped() {
        if isAddedToCart {
            coordinator?.showCart()
        } else {
            shop.makeAddedToCart(withId: id)
        }
    }
    
    func viewWillAppear() {
        setUpdate()
        getDataFromModel(for: id)
        updateViewCompletion?(.all)
    }
    
    func viewWillDisappear() {
        coordinator?.itemDetailDidFinish()
    }
}
