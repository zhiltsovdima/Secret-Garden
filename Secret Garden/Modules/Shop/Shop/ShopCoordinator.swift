//
//  ShopCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol ShopCoordinatorProtocol: AnyObject {
    func showItemDetail(id: String)
    func showFavorites()
    func showCart()
}

final class ShopCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
            
    private var navigationController: UINavigationController
    
    lazy private var shop = Shop(dbManager: dbManager)
    private let dbManager = DBManager()
        
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ShopViewModel(coordinator: self, shop: shop)
        let shopView = ShopViewController(viewModel: viewModel)
        navigationController.setViewControllers([shopView], animated: false)
    }
    
    func getController() -> UINavigationController {
        return navigationController
    }
}

extension ShopCoordinator: ShopCoordinatorProtocol {
    
    func showItemDetail(id: String) {
        let itemDetailCoordinator = ItemDetailCoordinator(navigationController: navigationController, shop: shop, id: id)
        itemDetailCoordinator.start()
        itemDetailCoordinator.parentCoordinator = self
        childCoordinators.append(itemDetailCoordinator)
    }
    
    func showFavorites() {
        let favoritesCoordinator = FavoritesCoordinator(navigationController: navigationController, shop: shop)
        favoritesCoordinator.start()
        favoritesCoordinator.parentCoordinator = self
        childCoordinators.append(favoritesCoordinator)
    }
    
    func showCart() {
        let cartCoordinator = CartCoordinator(navigationController: navigationController, shop: shop)
        cartCoordinator.start()
        cartCoordinator.parentCoordinator = self
        childCoordinators.append(cartCoordinator)
    }
    
    
}
