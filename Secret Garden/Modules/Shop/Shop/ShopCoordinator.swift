//
//  ShopCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

protocol ShopCoordinatorProtocol: AnyObject {
    func showItemDetail()
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
    
    func showItemDetail() {
        
    }
    
    func showFavorites() {
        
    }
    
    func showCart() {
        
    }
    
    
}
