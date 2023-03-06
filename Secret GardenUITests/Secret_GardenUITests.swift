//
//  Secret_GardenUITests.swift
//  Secret GardenUITests
//
//  Created by Dima Zhiltsov on 28.10.2022.
//

import XCTest

final class Secret_GardenUITests: XCTestCase {

    override func setUpWithError() throws {

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testAddNewPlant_NoImageError() throws {
        let app = XCUIApplication()
        app.launch()
                
        app.tabBars["Tab Bar"].buttons["My Garden"].tap()
        app.navigationBars["My Garden"].buttons["Add"].tap()
        app.textFields["Give your plant a name"].tap()
        app.buttons["Save"].tap()
        
        XCTAssert(app.staticTexts["You have to add the Image"].exists)
    }

}
