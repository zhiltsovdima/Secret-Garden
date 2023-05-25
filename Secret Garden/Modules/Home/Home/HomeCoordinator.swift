//
//  HomeCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    func moveToGarden()
    func moveToShop()
    func showArticleDetail(_ model: ArticleModel)
}

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: TabCoordinatorProtocol?
        
    private let navigationController: UINavigationController
    private let locationManager = LocationManager()
    private let networkManager: NetworkManagerProtocol
        
    init( _ navigationController: UINavigationController, _ networkManager: NetworkManagerProtocol) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    func start() {
        let viewModel = HomeViewModel(self, locationManager, networkManager)
        let homeView = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeView], animated: false)
    }
}

// MARK: - HomeCoordinatorProtocol

extension HomeCoordinator: HomeCoordinatorProtocol {
    func moveToGarden() {
        parentCoordinator?.switchToTab(tab: .garden)
    }
    
    func moveToShop() {
        parentCoordinator?.switchToTab(tab: .shop)
    }
    
    func showArticleDetail(_ model: ArticleModel) {
        let viewModel = DetailArticleViewModel(self, networkManager, model)
        let view = DetailArticleController(viewModel: viewModel)
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(view, animated: true)
    }
}
