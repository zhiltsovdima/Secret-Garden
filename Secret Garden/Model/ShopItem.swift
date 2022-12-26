//
//  ShopItem.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 10.12.2022.
//

import UIKit

class ShopItem {
    var id: Int?

    let name: String?
    let latinName: String?
    let category: String?
    let description: String?
    let price: String?
    let size: String?
    let petFriendly: String?
    let careLevel: String?
    let origin: String?
    let light: String?
    let humidity: String?
    let temperature: String?
    let imageString: String?
    
    var image: UIImage?
    
    var isFavorite = false
    var isAddedToCart = false
    
    private var isDownloading = false
    private var callback: ((UIImage?) -> Void)?
    
    init(name: String?, latinName: String?, category: String?, description: String?, price: String?, size: String?, petFriendly: String?, careLevel: String?, origin: String?, light: String?, humidity: String?, temperature: String?, imageString: String?) {
        self.name = name
        self.latinName = latinName
        self.category = category
        self.description = description
        self.price = price
        self.size = size
        self.petFriendly = petFriendly
        self.careLevel = careLevel
        self.origin = origin
        self.light = light
        self.humidity = humidity
        self.temperature = temperature
        self.imageString = imageString
    }
    
    func downloadData(completion: ((UIImage?) -> Void)?) {
        if let image {
            completion?(image)
            return
        }
        
        guard !isDownloading else {
            self.callback = completion
            return
        }
        isDownloading = true
        
        guard let imageString else { return }
        DBManager.shared.getImage(name: imageString) { [weak self] fetchedImage in
            self?.image = fetchedImage
            self?.callback?(self?.image)
            self?.callback = nil
            completion?(self?.image)
        }
    }
}
