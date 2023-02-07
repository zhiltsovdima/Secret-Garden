//
//  FavoritesViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    var tableData: [FavoriteCellModel] { get }
    var isEmptyTableData: Bool { get }
    var updateCellCompletion: ((IndexPath) -> Void)? { get set }

    func unfavoriteButtonTapped(id: String, indexPath: IndexPath)
    func viewWillDisappear()
}

// MARK: - FavoritesViewModel

final class FavoritesViewModel {
    
    var tableData = [FavoriteCellModel]() {
        didSet {
            isEmptyTableData = tableData.isEmpty
        }
    }
    var isEmptyTableData = true
    
    private weak var coordinator: FavoritesCoordinatorProtocol?
    private let shop: Shop
    
    var updateCellCompletion: ((IndexPath) -> Void)?
    
    init(coordinator: FavoritesCoordinatorProtocol, shop: Shop) {
        self.coordinator = coordinator
        self.shop = shop
        self.getTableData()
    }
    
    private func getTableData() {
        tableData = shop.items
            .filter { $0.isFavorite == true }
            .compactMap { FavoriteCellModel(
                id: $0.id,
                name: $0.name,
                price: $0.price,
                image: $0.image
            )}
    }
    
}

// MARK: - FavoritesViewModelProtocol

extension FavoritesViewModel: FavoritesViewModelProtocol {
    
    func unfavoriteButtonTapped(id: String, indexPath: IndexPath) {
        shop.makeFavoriteItem(withId: id)
        tableData.remove(at: indexPath.row)
        updateCellCompletion?(indexPath)
    }
    
    func viewWillDisappear() {
        coordinator?.favoritesDidFinish()
    }
}
