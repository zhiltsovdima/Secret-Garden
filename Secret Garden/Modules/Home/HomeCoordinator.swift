//
//  HomeCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    
}

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    private let locationManager = LocationManager()
    private let networkManager: NetworkManagerProtocol
        
    init(_ navigationController: UINavigationController, _ networkManager: NetworkManagerProtocol) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    func start() {
        let viewModel = HomeViewModel(self, locationManager, networkManager)
        let homeView = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeView], animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
}
