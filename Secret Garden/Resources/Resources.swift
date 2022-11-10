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
        static let tipBackground = UIColor(named: "TipsBackground")
        
        static let backgroundColor = UIColor(named: "WhiteBackground")
        static let backgroundFields = #colorLiteral(red: 0.9363515973, green: 0.9363515973, blue: 0.9363515973, alpha: 1)
    }
    
    enum Strings {
        enum TabBar {
            static let home = "Home"
            static let garden = "My Garden"
            static let shop = "Shop"
        }
        enum Common {
            static let name = "Name"
            static let save = "Save"
            static let cancel = "Cancel"
        }
        enum AddPlant {
            static let titleController = "Add a new plant"
            static let titleAlert = "Chose your image"
            static let camera = "Take a photo"
            static let photoLibrary = "Open the Photo Library"
            static let placeholder = "Give your plant a name"
        }
        enum Home {
            static let tipTitle = "Совет дня"
            static let tipBody = "Начинай свой день со стакана воды"
        }
        enum Options {
            static let rename = "Rename"
            static let delete = "Delete"
        }
        enum FolderForSaveData {
            static let garden = "Garden"
        }
    }
    
    enum Images {
        enum TabBar {
            static let home = UIImage(named: "home")
            static let garden = UIImage(systemName: "leaf")
            static let shop = UIImage(systemName: "bag")
        }
        enum Common {
            static let camera = UIImage(systemName: "camera.circle.fill")
            static let moreOptions = UIImage(systemName: "ellipsis")
            static let back = UIImage(systemName: "chevron.backward.circle.fill")
        }
        enum Home {
            static let tip = UIImage(named: "Plant")
        }
    }
    
    enum Cells {
        static let plantCell = "PlantCell"
        static let plantOptionsCell = "PlantOptionsCell"
    }
}

