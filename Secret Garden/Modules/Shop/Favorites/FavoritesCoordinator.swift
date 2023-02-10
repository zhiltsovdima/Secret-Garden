//
//  FavoritesCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import UIKit.UINavigationController

protocol FavoritesCoordinatorProtocol: AnyObject {
    func showItemDetail(id: String) 
    func favoritesDidFinish()
}

final class FavoritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    private var navigationController: UINavigationController
    private let shop: Shop
    
    init(navigationController: UINavigationController, shop: Shop) {
        self.navigationController = navigationController
        self.shop = shop
    }
    
    func start() {
        let viewModel = FavoritesViewModel(coordinator: self, shop: shop)
        let favoritesView = FavoritesViewController(viewModel: viewModel)
        navigationController.pushViewController(favoritesView, animated: true)
    }
}

extension FavoritesCoordinator: FavoritesCoordinatorProtocol {
    
    func showItemDetail(id: String) {
        let itemDetailCoordinator = ItemDetailCoordinator(navigationController: navigationController, shop: shop, id: id)
        itemDetailCoordinator.start()
        itemDetailCoordinator.parentCoordinator = self
        childCoordinators.append(itemDetailCoordinator)
    }
    
    func favoritesDidFinish() {
        if childCoordinators.isEmpty {
            parentCoordinator?.childDidFinish(self)
        }
    }
}
