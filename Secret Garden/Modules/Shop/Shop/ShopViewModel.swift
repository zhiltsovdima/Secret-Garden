//
//  ShopViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 27.01.2023.
//

import Foundation

// MARK: - ShopViewModelProtocol

protocol ShopViewModelProtocol: AnyObject {
    var collectionData: [ShopItemCellModel] { get }
    var updateCellCompletion: ((Int?) -> Void)? { get set }
    
    func updateCollectionData(by: ShopCategory)
    func updateImage(index: Int, isUpdateCell: Bool)
    func navBarFavoritesButtonTapped()
    func navBarCartButtonTapped()
    func favoriteButtonTapped(id: String, indexPath: IndexPath)
    func cartButtonTapped(id: String, indexPath: IndexPath)
    func collectionItemTapped(_ indexPath: IndexPath)
}

// MARK: - ShopViewModel

final class ShopViewModel {
    
    var collectionData = [ShopItemCellModel]()

    private weak var coordinator: ShopCoordinatorProtocol?
    private let shop: Shop
    
    var updateCellCompletion: ((Int?) -> Void)?
    
    init(coordinator: ShopCoordinatorProtocol, shop: Shop) {
        self.coordinator = coordinator
        self.shop = shop
        self.setUpdate()
    }
    
    private func setUpdate() {
        shop.updateViewCompletion = { [weak self] id, updatedProperty in
            guard let index = self?.collectionData.firstIndex(where: { $0.id == id}) else { return }
            switch updatedProperty {
            case .favorite(let boolValue):
                self?.collectionData[index].isFavorite = boolValue
            case .cart(let boolValue):
                self?.collectionData[index].isAddedToCart = boolValue
            default: break
            }
            self?.updateCellCompletion?(index)
        }
    }
    
}

// MARK: - ShopViewModelProtocol

extension ShopViewModel: ShopViewModelProtocol {
    
    func updateCollectionData(by category: ShopCategory) {
        var shopItems = shop.items
            .sorted(by: { $0.name < $1.name })
        if category == .indoor || category == .outdoor || category == .fertilizer {
            shopItems = shopItems
                .filter { $0.category == category }
        }
        collectionData = shopItems
            .compactMap { ShopItemCellModel(
                id: $0.id,
                name: $0.name,
                image: $0.image,
                isFavorite: $0.isFavorite,
                isAddedToCart: $0.isAddedToCart
            ) }
        updateCellCompletion?(nil)
    }
    
    func updateImage(index: Int, isUpdateCell: Bool) {
        guard collectionData[index].image == nil else { return }
        let id = collectionData[index].id
        guard let item = shop.items.first(where: { $0.id == id }) else { return }
        shop.downloadData(for: item) { [weak self] fetchedImage in
            self?.collectionData[index].image = fetchedImage
            guard isUpdateCell else { return }
            self?.updateCellCompletion?(index)
        }
    }
    
    func navBarFavoritesButtonTapped() {
        coordinator?.showFavorites()
    }
    
    func navBarCartButtonTapped() {
        coordinator?.showCart()
    }
    
    func favoriteButtonTapped(id: String, indexPath: IndexPath) {
        collectionData[indexPath.item].isFavorite = !collectionData[indexPath.item].isFavorite
        shop.makeFavoriteItem(withId: id)
    }
    
    func cartButtonTapped(id: String, indexPath: IndexPath) {
        collectionData[indexPath.item].isAddedToCart = !collectionData[indexPath.item].isAddedToCart
        shop.makeAddedToCart(withId: id)
    }
    
    func collectionItemTapped(_ indexPath: IndexPath) {
        let id = collectionData[indexPath.item].id
        coordinator?.showItemDetail(id: id)
    }
    
}
