//
//  CartCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import UIKit.UINavigationController

protocol CartCoordinatorProtocol: AnyObject {
    func backToShop()
    func showItemDetail(id: String)
    func cartDidFinish()
}

final class CartCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    private var navigationController: UINavigationController
    private let shop: Shop
    
    init(navigationController: UINavigationController, shop: Shop) {
        self.navigationController = navigationController
        self.shop = shop
    }
    
    func start() {
        let viewModel = CartViewModel(coordinator: self, shop: shop)
        let cartView = CartViewController(viewModel: viewModel)
        navigationController.pushViewController(cartView, animated: true)
    }
    
}

extension CartCoordinator: CartCoordinatorProtocol {
    
    func backToShop() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showItemDetail(id: String) {
        let itemDetailCoordinator = ItemDetailCoordinator(navigationController: navigationController, shop: shop, id: id)
        itemDetailCoordinator.start()
        itemDetailCoordinator.parentCoordinator = self
        childCoordinators.append(itemDetailCoordinator)
    }
    
    func cartDidFinish() {
        if childCoordinators.isEmpty {
            parentCoordinator?.childDidFinish(self)
        }
    }
}
