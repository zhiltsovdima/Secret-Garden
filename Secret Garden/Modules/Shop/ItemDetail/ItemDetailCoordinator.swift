//
//  ItemDetailCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import UIKit.UINavigationController

protocol ItemDetailCoordinatorProtocol: AnyObject {
    func showCart()
    func itemDetailDidFinish()
}

final class ItemDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    private var navigationController: UINavigationController
    private let shop: Shop
    private let id: String
    
    init(navigationController: UINavigationController, shop: Shop, id: String) {
        self.navigationController = navigationController
        self.shop = shop
        self.id = id
    }
    
    func start() {
        let viewModel = ItemDetailViewModel(coordinator: self, shop: shop, id: id)
        let itemDetailView = ItemDetailController(viewModel: viewModel)
        navigationController.pushViewController(itemDetailView, animated: true)
    }
    
}

extension ItemDetailCoordinator: ItemDetailCoordinatorProtocol {
    
    func showCart() {
        if parentCoordinator is CartCoordinator {
            navigationController.popViewController(animated: true)
        } else {
            let cartCoordinator = CartCoordinator(navigationController: navigationController, shop: shop)
            cartCoordinator.start()
            cartCoordinator.parentCoordinator = self
            childCoordinators.append(cartCoordinator)
        }
    }
    
    func itemDetailDidFinish() {
        if childCoordinators.isEmpty {
            shop.updateDetailViewCompletion = nil
            parentCoordinator?.childDidFinish(self)
        }
    }
}
