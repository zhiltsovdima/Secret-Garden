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
    func showArticleDetail(_ model: ArticleViewModelProtocol)
}

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: TabCoordinatorProtocol?
        
    private let navigationController: UINavigationController
    private let locationManager = LocationManager()
    private let weatherService: WeatherServiceProtocol
    private let newsService: NewsServiceProtocol
        
    init( _ navigationController: UINavigationController, _ networkManager: NetworkManagerProtocol) {
        self.navigationController = navigationController
        self.weatherService = WeatherService(networkManager)
        self.newsService = NewsService(networkManager)
    }
    
    func start() {
        let viewModel = HomeViewModel(self, locationManager, weatherService, newsService)
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
    
    func showArticleDetail(_ model: ArticleViewModelProtocol) {
        let viewModel = DetailArticleViewModel(self, newsService, model)
        let view = DetailArticleController(viewModel: viewModel)
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(view, animated: true)
    }
}
