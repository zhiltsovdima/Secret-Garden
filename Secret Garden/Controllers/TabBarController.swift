//
//  TabBarController.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

enum Tabs: Int {
    case home
    case plants
    case shop
}

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    private func configure() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.backgroundColor = Resources.Colors.tabBarColor
                
        let homeViewController = UIViewController()
        let plantsViewController = UIViewController()
        let shopViewController = UIViewController()

        homeViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home,
                                                     image: Resources.Images.TabBar.home,
                                                     tag: Tabs.home.rawValue)
        plantsViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.plants,
                                                     image: Resources.Images.TabBar.plants,
                                                     tag: Tabs.plants.rawValue)
        shopViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.shop,
                                                     image: Resources.Images.TabBar.shop,
                                                     tag: Tabs.shop.rawValue)
        
        setViewControllers([
            homeViewController,
            plantsViewController,
            shopViewController
        ], animated: false)
    }

}
