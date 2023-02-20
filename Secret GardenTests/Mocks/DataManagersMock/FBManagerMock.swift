//
//  FBManagerMock.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 15.02.2023.
//

import UIKit
@testable import Secret_Garden

final class FBManagerMock: FBManagerProtocol {
    
    var shopItems = [ShopItem]()
    var images = [String: UIImage]()
    
    func getPost(completion: @escaping ([ShopItem]) -> Void) {
        completion(shopItems)
    }
    
    func getImage(name: String?, completion: @escaping (UIImage) -> Void) {
        guard let name else { return }
        completion(images[name]!)
    }
}
