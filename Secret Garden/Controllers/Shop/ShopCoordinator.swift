//
//  ShopCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit.UINavigationController

final class ShopCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
            
    private var navigationController: UINavigationController
        
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let shopView = ShopViewController()
        navigationController.setViewControllers([shopView], animated: false)
    }
    
    func getController() -> UINavigationController {
        return navigationController
    }
}
