//
//  HomeCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController!
        
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeView = HomeViewController()
        navigationController.setViewControllers([homeView], animated: false)
    }
    
    func getController() -> UINavigationController {
        return navigationController
    }
}
