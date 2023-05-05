//
//  TabCoordinator.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 13.01.2023.
//

import UIKit

final class TabCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let tabBarController: UITabBarController
    private let networkManager = NetworkManager()
    
    init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .garden, .shop]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UIViewController] = pages.map { getControllers(for: $0) }
        prepareTabBarController(withControllers: controllers)
    }
    
    private func getControllers(for page: TabBarPage) -> UINavigationController {
        
        let navigationController = NavBarController()
        navigationController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                       image: page.iconValue(),
                                                       tag: page.pageOrderNumber()
        )
        let childCoordinator = getChildCoordinator(for: page, navigationController)
        childCoordinator.start()
        childCoordinators.append(childCoordinator)
        return navigationController
    }
    
    private func getChildCoordinator(for page: TabBarPage, _ navigationController: UINavigationController) -> Coordinator {
        switch page {
        case .home:
            navigationController.setNavigationBarHidden(true, animated: false)
            return HomeCoordinator(navigationController, networkManager)
        case .garden:
            return GardenCoordinator(navigationController, networkManager)
        case .shop:
            return ShopCoordinator(navigationController)
        }
    }
    
    private func prepareTabBarController(withControllers controllers: [UIViewController]) {
        
        tabBarController.setViewControllers(controllers, animated: false)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        
        tabBarController.tabBar.tintColor = Resources.Colors.accent
        tabBarController.tabBar.backgroundColor = Resources.Colors.tabBarColor
    }
}

// MARK: - TabBarPage

enum TabBarPage {
    case home
    case garden
    case shop
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return Resources.Strings.TabBar.home
        case .garden:
            return Resources.Strings.TabBar.garden
        case .shop:
            return Resources.Strings.TabBar.shop
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .garden:
            return 1
        case .shop:
            return 2
        }
    }
    
    func iconValue() -> UIImage? {
        switch self {
        case .home:
            return Resources.Images.TabBar.home
        case .garden:
            return Resources.Images.TabBar.garden
        case .shop:
            return Resources.Images.TabBar.shop
        }
    }
}
