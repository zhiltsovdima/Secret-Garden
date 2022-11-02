//
//  Resources.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

enum Resources {
    
    enum Colors {
        static let accent = UIColor(named: "TabBarAccent")
        static let tabBarColor = UIColor(named: "TabBarColor")
        
        static let backgroundColor = UIColor(named: "WhiteBackground")
    }
    
    enum Strings {
        enum TabBar {
            static let home = "Home"
            static let garden = "My Garden"
            static let shop = "Shop"
        }
        enum Common {
            static let name = "Enter the name:"
            static let save = "Save"
            static let cancel = "Cancel"
        }
        enum AddPlant {
            static let titleAlert = "Chose your image"
            static let camera = "Take a photo"
            static let photoLibrary = "Open the Photo Library"
        }
    }
    
    enum Images {
        enum TabBar {
            static let home = UIImage(named: "home")
            static let garden = UIImage(named: "plants")
            static let shop = UIImage(named: "shop")
        }
        enum Common {
            static let camera = UIImage(systemName: "camera.circle.fill")
        }
    }
    
    enum Cells {
        static let plantCell = "PlantCell"
    }
}

