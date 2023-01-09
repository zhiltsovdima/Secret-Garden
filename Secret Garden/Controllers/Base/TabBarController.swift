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
        
    init(_ controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        configure(controllers)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ controllers: [UIViewController]) {
        tabBar.tintColor = Resources.Colors.accent
        tabBar.backgroundColor = Resources.Colors.tabBarColor
        
        controllers.forEach { vc in
            let navVC = vc as? NavBarController
            if vc is HomeViewController {
                vc.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home,
                                             image: Resources.Images.TabBar.home,
                                             tag: Tabs.home.rawValue)
            } else if navVC?.topViewController is PlantsViewController {
                vc.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.garden,
                                             image: Resources.Images.TabBar.garden,
                                             tag: Tabs.garden.rawValue)
            } else if navVC?.topViewController is ShopViewController {
                vc.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.shop,
                                             image: Resources.Images.TabBar.shop,
                                             tag: Tabs.shop.rawValue)
            }
        }
        setViewControllers(controllers, animated: false)
    }
}
