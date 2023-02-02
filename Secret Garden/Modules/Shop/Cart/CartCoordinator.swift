//
//  CartCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 02.02.2023.
//

import UIKit.UINavigationController

protocol CartCoordinatorProtocol: AnyObject {
    
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
        
    }
    
}

extension CartCoordinator: CartCoordinatorProtocol {
    
}
