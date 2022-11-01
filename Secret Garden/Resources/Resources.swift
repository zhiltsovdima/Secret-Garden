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
        
        static let backgroundColor = UIColor(named: "WhiteBackground")
    }
    
    enum Strings {
        enum TabBar {
            static let home = "Home"
            static let garden = "My Garden"
            static let shop = "Shop"
        }
    }
    
    enum Images {
        enum TabBar {
            static let home = UIImage(named: "home")
            static let garden = UIImage(named: "plants")
            static let shop = UIImage(named: "shop")
        }
    }
    
    enum Cells {
        static let plantCell = "PlantCell"
    }
}

