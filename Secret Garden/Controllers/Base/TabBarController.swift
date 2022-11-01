//
//  TabBarController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

enum Tabs: Int {
    case home
    case garden
    case shop
}

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    private func configure() {
        tabBar.tintColor = Resources.Colors.accent
        tabBar.backgroundColor = Resources.Colors.tabBarColor
                
        let homeViewController = HomeViewController()
        let plantsViewController = PlantsViewController()
        let shopViewController = ShopViewController()
        
        let plantsNavigationController = NavBarController(rootViewController: plantsViewController)
        let shopNavigationController = NavBarController(rootViewController: shopViewController)

        homeViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home,
                                                     image: Resources.Images.TabBar.home,
                                                     tag: Tabs.home.rawValue)
        plantsNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.garden,
                                                     image: Resources.Images.TabBar.garden,
                                                     tag: Tabs.garden.rawValue)
        shopViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.shop,
                                                     image: Resources.Images.TabBar.shop,
                                                     tag: Tabs.shop.rawValue)
        
        setViewControllers([
            homeViewController,
            plantsNavigationController,
            shopNavigationController
        ], animated: false)
    }
}
