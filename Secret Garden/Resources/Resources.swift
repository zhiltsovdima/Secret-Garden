//
//  Resources.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

enum Resources {
    
    enum Colors {
        static let active = UIColor(named: "TabBarAccent")
        static let tabBarColor = UIColor(named: "TabBarColor")
    }
    
    enum Strings {
        enum TabBar {
            static let home = "Home"
            static let plants = "My Plants"
            static let shop = "Shop"
        }
    }
    
    enum Images {
        enum TabBar {
            static let home = UIImage(named: "home")
            static let plants = UIImage(named: "plants")
            static let shop = UIImage(named: "shop")
        }
    }
}

