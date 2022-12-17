//
//  Secret_GardenTests.swift
//  Secret GardenTests
//
//  Created by Dima Zhiltsov on 28.10.2022.
//

import XCTest
@testable import Secret_Garden

final class Secret_GardenTests: XCTestCase {
    
    var shop: Shop!
    let item = ShopItem( id: 0,
                         name: "name",
                         latinName: "latinName",
                         category: nil,
                         description: nil,
                         price: nil,
                         size: nil,
                         petFriendly: nil,
                         careLevel: nil,
                         origin: nil,
                         light: nil,
                         humidity: nil,
                         temperature: nil,
                         imageString: nil
    )

    override func setUpWithError() throws {
        shop = Shop()
        shop.items.append(item)

    }

    override func tearDownWithError() throws {
        shop = nil
    }
    
    func testMakeFavoriteItem() throws {
        
        var expectedFavorite = false
        var actualFavorite: Bool {
            shop.items[0].isFavorite
        }
        XCTAssertEqual(expectedFavorite, actualFavorite)
        XCTAssertTrue(shop.favorites.isEmpty)
        
        expectedFavorite = true
        shop.makeFavoriteItem(withId: 0, to: true)
        XCTAssertEqual(expectedFavorite, actualFavorite)
        XCTAssertFalse(shop.favorites.isEmpty)

    }
    
    func testMakeAddedToCart() throws {
        var expectedAdded = false
        var actualAdded: Bool {
            shop.items[0].isAddedToCart
        }
        XCTAssertEqual(expectedAdded, actualAdded)
        XCTAssertTrue(shop.cart.isEmpty)
        
        expectedAdded = true
        shop.makeAddedToCart(withId: 0, to: true)
        XCTAssertEqual(expectedAdded, actualAdded)
        XCTAssertFalse(shop.cart.isEmpty)

    }

}
