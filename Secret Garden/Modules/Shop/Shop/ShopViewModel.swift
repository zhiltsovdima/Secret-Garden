//
//  ShopViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 27.01.2023.
//

import Foundation

// MARK: - GardenViewModelProtocol

protocol ShopViewModelProtocol: AnyObject {
    var collectionData: [ShopItemCellModel] { get }
    var updateCellCompletion: ((IndexPath?) -> Void)? { get set }
    func updateModel(by: ShopCategory)
    func updateImage(with indexPath: IndexPath)
    func navBarFavoritesButtonTapped()
    func navBarCartButtonTapped()
    func favoriteButtonTapped(id: Int?, indexPath: IndexPath)
    func cartButtonTapped(id: Int?, indexPath: IndexPath)

}

// MARK: - GardenViewModel

final class ShopViewModel {
    
    var collectionData = [ShopItemCellModel]()

    private weak var coordinator: ShopCoordinatorProtocol?
    private let shop: Shop
    
    var updateCellCompletion: ((IndexPath?) -> Void)?
    
    init(coordinator: ShopCoordinatorProtocol, shop: Shop) {
        self.coordinator = coordinator
        self.shop = shop
        self.setUpdate()
    }
    
    private func setUpdate() {
        shop.updateViewCompletion = { [weak self] indexPath in
            self?.updateCellCompletion?(indexPath)
        }
    }
    
}

extension ShopViewModel: ShopViewModelProtocol {
    
    func updateModel(by category: ShopCategory) {
        var shopItems: [ShopItem]
        
        switch category {
        case .all:
            shopItems = shop.items
                .sorted(by: { $0.name! < $1.name! })
        case .indoor:
            shopItems = shop.items
                .filter { $0.category?.lowercased() == category.rawValue.lowercased() }
        case .outdoor:
            shopItems = shop.items
                .filter { $0.category?.lowercased() == category.rawValue.lowercased() }
        case .fertilizer:
            shopItems = shop.items
                .filter { $0.category?.lowercased() == category.rawValue.lowercased() }
        }
        
        collectionData = shopItems
            .compactMap { ShopItemCellModel(
                id: $0.id!,
                name: $0.name!,
                image: $0.image,
                isFavorite: $0.isFavorite,
                isAddedToCart: $0.isAddedToCart
            ) }
        updateCellCompletion?(nil)
    }
    
    func updateImage(with indexPath: IndexPath) {
        let id = collectionData[indexPath.item].id
        shop.downloadData(for: shop.items[id]) { [weak self] fetchedImage in
            self?.collectionData[indexPath.item].image = fetchedImage
            self?.updateCellCompletion?(indexPath)
        }
    }
    
    func navBarFavoritesButtonTapped() {
        coordinator?.showFavorites()
    }
    
    func navBarCartButtonTapped() {
        coordinator?.showCart()
    }
    
    func favoriteButtonTapped(id: Int?, indexPath: IndexPath) {
        guard let id else { return }
        collectionData[indexPath.item].isFavorite = !collectionData[indexPath.item].isFavorite
        shop.makeFavoriteItem(withId: id, at: indexPath)
    }
    func cartButtonTapped(id: Int?, indexPath: IndexPath) {
        guard let id else { return }
        collectionData[indexPath.item].isAddedToCart = !collectionData[indexPath.item].isAddedToCart
        shop.makeAddedToCart(withId: id, at: indexPath)
    }
    
    
}
