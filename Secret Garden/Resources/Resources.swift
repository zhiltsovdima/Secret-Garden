//
//  Resources.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 29.10.2022.
//

import UIKit

enum Resources {
    
    //MARK: - Colors

    enum Colors {
        static let accent = UIColor(named: "TabBarAccent")
        static let tabBarColor = UIColor(named: "TabBarColor")
        static let tipBackground = UIColor(named: "TipsBackground")
        
        static let backgroundColor = UIColor(named: "Background")
        static let backgroundFields = UIColor(named: "FieldsBackground")
        
        static let blackOnWhite = UIColor(named: "FontBlackOnWhite")
        static let whiteOnBlack = UIColor(named: "FontWhiteOnBlack")
        
        static let shopButton = UIColor(named: "ShopButton")
        static let secondAccent = UIColor(named: "SecondAccent")
        
        static let lightText: UIColor = .systemGray
        
        static let gardenButtonHome = UIColor(named: "GardenButtonHome")
        static let shopButtonHome = UIColor(named: "ShopButtonHome")
    }
    
    //MARK: - Strings
    
    enum Strings {
        
        static let degreeSymbol = "\u{00B0}"
        
        enum TabBar {
            static let home = "Home"
            static let garden = "My Garden"
            static let shop = "Shop"
        }
        enum Common {
            static let name = "Name"
            static let save = "Save"
            static let cancel = "Cancel"
            
            enum Detail {
                static let careLevel = "Care Level"
                static let petFriendly = "Pet Friendly"
                static let size = "Size"
                static let origin = "Origin"
                static let light = "Light"
                static let humidity = "Humidity"
                static let watering = "Watering"
                static let temperature = "Temperature"
                static let insects = "Insects"
                
                static let all = [Strings.Common.Detail.light,
                                  Strings.Common.Detail.temperature,
                                  Strings.Common.Detail.watering,
                                  Strings.Common.Detail.insects,
                                  Strings.Common.Detail.origin]
            }
        }
        enum AddPlant {
            static let titleController = "Add a new plant"
            static let titleAlert = "Chose your image"
            static let camera = "Take a photo"
            static let photoLibrary = "Open the Photo Library"
            static let placeholder = "Give your plant a name"
            static let emptyImage = "You have to add the Image"
            static let emptyName = "You have to add the plant name"
            static let notValidName = "Your plant name must contain only letters"
            static let examplePlant = "For example: Croton or Peace lily"
        }
        enum Home {
            static let tipTitle = "Совет дня"
            static let descriptionTitle = "На данный момент я еще не реализовал интересный, функциональный и красивый экран Home, поэтому пока что здесь будет простое описание функционала всего приложения."
            static let descriptionBody = "\n\n Экран Garden:\n - можно добавить в коллекцию растений новое, указав тип растения и добавив его фото\n - удалить/отредактировать растение\n - открыть детальный обзор растения и получить его характеристики(при условии что такой тип растения есть в бд)\n\n Экран Shop:\n - посмотреть имеющиеся товары в магазине, есть фильтр по категориям товаров\n - посмотреть детальный обзор товара\n - добавить товар в корзину/избранное"
        }
        enum Options {
            static let edit = "Edit"
            static let delete = "Delete"
        }
        enum PathForStoringData {
            static let folderName = "Secret_Garden"
            static let fileName = "Garden_Data"
        }
        enum Shop {
            
            enum Categories {
                static let all = "All"
                static let indoor = "Indoor"
                static let outdoor = "Outdoor"
                static let fertilizer = "Fertilizer"
            }
            
            static let addToCart = "Add to Cart"
            static let added = "Go to Cart"
            static let price = "Price"
            static let checkout = "Checkout"
            static let total = "Total"
            static let subTotal = "Sub Total"
            static let shipping = "Shipping"
            static let emptyLabel = "Please add to Cart something!"
            static let emptyButton = "Back to the Shop"
        }
        enum DataBase {
            static let collectionNameInDataBase = "SecretGarden"
        }
    }
    
    //MARK: - Images
    
    enum Images {
        enum TabBar {
            static let home = UIImage(systemName: "house")
            static let garden = UIImage(systemName: "leaf")
            static let shop = UIImage(systemName: "bag")
        }
        enum Common {
            static let defaultPlant = UIImage(named: "DefaultPlant")
            static let failedImage = UIImage(named: "FailedImage")
            static let shopPlant = UIImage(named: "ShopPlant")
            static let emptyCollection = UIImage(named: "EmptyCollection")
            static let camera = UIImage(systemName: "camera.circle.fill")
            static let moreOptions = UIImage(systemName: "ellipsis")
            static let back = UIImage(systemName: "chevron.backward.circle.fill")
            static let favorites = UIImage(systemName: "heart.circle")
            static let addToFavorite = UIImage(systemName: "heart")
            static let addToFavoriteFill = UIImage(systemName: "heart.fill")
            static let cart = UIImage(systemName: "cart.circle")
            static let delete = UIImage(systemName: "xmark")
        }
        enum Home {
            static let tip = UIImage(named: "PlantForTip")
            static let garden = UIImage(named: "Plants")?.withTintColor(.white)
            static let shop = UIImage(named: "Shop")?.withTintColor(.white)
            static let plantRecognizer = UIImage(named: "Recognizer")?.withTintColor(.white)
        }
        
        enum Features {
            static let size = UIImage(systemName: "ruler.fill")
            static let careLevel = UIImage(systemName: "chart.bar.fill")
            static let petFriendly = UIImage(systemName: "pawprint.fill")
            static let origin = UIImage(systemName: "globe.desk.fill")
            static let light = UIImage(systemName: "sun.max.fill")
            static let humidity = UIImage(systemName: "drop.fill")
            static let temperature = UIImage(systemName: "thermometer")
            static let insects = UIImage(systemName: "ladybug")
        }
        
        enum Weather {
            static let storm = UIImage(named: "storm")
            static let clouds = UIImage(named: "clouds")
            static let partyCloudy = UIImage(named: "party-cloudy-day")
            static let partyRain = UIImage(named: "rain-cloud")
            static let rain = UIImage(named: "rain")
            static let rainfall = UIImage(named: "rainfall")
            static let snow = UIImage(named: "snow")
            static let sun = UIImage(named: "sun")
            static let windy = UIImage(named: "windy")
            static let night = UIImage(named: "night")
        }
    }
    
    //MARK: - Identifiers

    enum Identifiers {
        static let plantCell = "PlantCell"
        static let plantOptionsCell = "PlantOptionsCell"
        static let itemCell = "ItemCell"
        static let categoriesView = "HeaderCollectionReusableView"
        static let categoryCell = "CategoryCell"
        static let favoriteCell = "FavoriteCell"
        static let cartCell = "CartCell"
        static let featureCell = "FeatureCell"
        static let articleCell = "ArticleCell"

    }
    
    enum Constants {
        enum shopVC {
            static let columnCount: CGFloat = 2.0
            static let aspectRatio: CGFloat = 2.0 / 3.0
            static let itemsSpacing: CGFloat = 20.0
        }
    }
}

