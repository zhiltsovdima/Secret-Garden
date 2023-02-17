//
//  ShopTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 15.02.2023.
//

import XCTest
@testable import Secret_Garden

final class ShopTests: XCTestCase {
    
    var sut: Shop!
    var fbManager: FBManagerProtocol!
    
    override func setUpWithError() throws {
        fbManager = FBManagerMock()
        sut = Shop(fbManager: fbManager)
    }

    override func tearDownWithError() throws {
        fbManager = nil
        sut = nil
    }
    
    func testMakeFavoriteItem() throws {
        let id = UUID().uuidString
        let features = ShopItemFeatures(careLevel: "careLevel", petFriendly: "petFriendly", width: "20", height: "30", light: "light", humidity: "humidity", minTemp: NSNumber(value: 16), maxTemp: NSNumber(value: 26), origin: "origin")
        
        let shopItem = ShopItem(id: id,
                                name: "Test Name",
                                latinName: "Test latin Name",
                                category: "Indoor",
                                description: "Description",
                                price: "$20.0",
                                imageString: "image",
                                features: features)
        sut.items = [shopItem]
        let expectedResult = !shopItem.isFavorite
        
        sut.makeFavoriteItem(withId: id)
        XCTAssertEqual(expectedResult, shopItem.isFavorite)
        sut.makeFavoriteItem(withId: id)
        XCTAssertEqual(!expectedResult, shopItem.isFavorite)
    }
    
    func testMakeAddedToCartItem() throws {
        let id = UUID().uuidString
        let features = ShopItemFeatures(careLevel: "careLevel", petFriendly: "petFriendly", width: "20", height: "30", light: "light", humidity: "humidity", minTemp: NSNumber(value: 16), maxTemp: NSNumber(value: 26), origin: "origin")
        
        let shopItem = ShopItem(id: id,
                                name: "Test Name",
                                latinName: "Test latin Name",
                                category: "Indoor",
                                description: "Description",
                                price: "$20.0",
                                imageString: "image",
                                features: features)
        sut.items = [shopItem]
        let expectedResult = !shopItem.isAddedToCart
        
        sut.makeAddedToCart(withId: id)
        XCTAssertEqual(expectedResult, shopItem.isAddedToCart)
        sut.makeAddedToCart(withId: id)
        XCTAssertEqual(!expectedResult, shopItem.isAddedToCart)
    }
    
}
