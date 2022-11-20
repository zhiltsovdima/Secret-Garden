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
        
        static let backgroundColor = UIColor(named: "Background")
        static let backgroundFields = UIColor(named: "FieldsBackground")
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
            static let edit = "Edit"
            static let delete = "Delete"
        }
        enum FolderForSaveData {
            static let garden = "Garden"
        }
        enum Shop {
            static let addToCart = "Add to Cart"
            static let collectionNameInDataBase = "SecretGarden"
            static let price = "Price" 
        }
    }
    
    enum Images {
        enum TabBar {
            static let home = UIImage(systemName: "house")
            static let garden = UIImage(systemName: "leaf")
            static let shop = UIImage(systemName: "bag")
        }
        enum Common {
            static let defaultPlant = UIImage(named: "DefaultPlant")
            static let camera = UIImage(systemName: "camera.circle.fill")
            static let moreOptions = UIImage(systemName: "ellipsis")
            static let back = UIImage(systemName: "chevron.backward.circle.fill")
            static let favorites = UIImage(systemName: "heart.circle")
            static let addToFavorite = UIImage(systemName: "heart")
            static let cart = UIImage(systemName: "cart.circle")
        }
        enum Home {
            static let tip = UIImage(named: "PlantForTip")
        }
    }
    
    enum Identifiers {
        static let plantCell = "PlantCell"
        static let plantOptionsCell = "PlantOptionsCell"
        static let itemCell = "ItemCell"
        static let categoriesView = "HeaderCollectionReusableView"
        static let categoryCell = "CategoryCell"
    }
    
    enum Constants {
        enum shopVC {
            static let columnCount: CGFloat = 2.0
            static let aspectRatio: CGFloat = 2.0 / 3.0
            static let itemsSpacing: CGFloat = 20.0
        }
    }
}

