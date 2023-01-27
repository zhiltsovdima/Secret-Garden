//
//  ShopViewModel.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 27.01.2023.
//

import Foundation

// MARK: - GardenViewModelProtocol

protocol ShopViewModelProtocol: AnyObject {

}

// MARK: - GardenViewModel

final class ShopViewModel {

    private weak var coordinator: ShopCoordinatorProtocol?
    private let shop: Shop
    
    init(coordinator: ShopCoordinatorProtocol, shop: Shop) {
        self.coordinator = coordinator
        self.shop = shop
    }
    
}

extension ShopViewModel: ShopViewModelProtocol {
    
}
