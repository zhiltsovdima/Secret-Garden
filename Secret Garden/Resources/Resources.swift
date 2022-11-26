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
        
        static let subHeader: UIColor = .systemGray
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
            
            enum Detail {
                static let careLevel = "Care Level"
                static let petFriendly = "Pet Friendly"
                static let size = "Size"
                static let origin = "Origin"
                static let light = "Light"
                static let humidity = "Humidity"
                static let temperature = "Temperature"
            }
            
            static let addToCart = "Add to Cart"
            static let added = "Added"
            static let collectionNameInDataBase = "SecretGarden"
            static let price = "Price"
            static let checkout = "Checkout"
            static let total = "Total"
            static let subTotal = "Sub Total"
            static let shipping = "Shipping"



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
            static let emptyCollection = UIImage(named: "EmptyCollection")
            static let camera = UIImage(systemName: "camera.circle.fill")
            static let moreOptions = UIImage(systemName: "ellipsis")
            static let back = UIImage(systemName: "chevron.backward.circle.fill")
            static let favorites = UIImage(systemName: "heart.circle")
            static let addToFavorite = UIImage(systemName: "heart")
            static let addToFavoriteFill = UIImage(systemName: "heart.fill")
            static let cart = UIImage(systemName: "cart.circle")
        }
        enum Home {
            static let tip = UIImage(named: "PlantForTip")
        }
        
        enum Shop {
            static let size = UIImage(systemName: "ruler.fill")
            static let careLevel = UIImage(systemName: "chart.bar.fill")
            static let petFriendly = UIImage(systemName: "pawprint.fill")
            static let origin = UIImage(systemName: "globe.desk.fill")
            static let light = UIImage(systemName: "sun.max.fill")
            static let humidity = UIImage(systemName: "drop.fill")
            static let temperature = UIImage(systemName: "thermometer")
        }
    }
    
    enum Identifiers {
        static let plantCell = "PlantCell"
        static let plantOptionsCell = "PlantOptionsCell"
        static let itemCell = "ItemCell"
        static let categoriesView = "HeaderCollectionReusableView"
        static let categoryCell = "CategoryCell"
        static let favoriteCell = "FavoriteCell"
        static let cartCell = "CartCell"

    }
    
    enum Fonts {
        static let general = UIFont(name: "Helvetica", size: 16)
        static let header = UIFont(name: "Helvetica-Bold", size: 24)
        static let subHeaders = UIFont(name: "Helvetica", size: 14)
        static let generalBold = UIFont(name: "Helvetica-Bold", size: 16)
    }
    
    enum Constants {
        enum shopVC {
            static let columnCount: CGFloat = 2.0
            static let aspectRatio: CGFloat = 2.0 / 3.0
            static let itemsSpacing: CGFloat = 20.0
        }
    }
}

