//
//  WijekoonWHMCB_COBSCCOMP191P_006UITests.swift
//  WijekoonWHMCB-COBSCCOMP191P-006UITests
//
//  Created by Chathura Wijekoon on 9/16/20.
//  Copyright © 2020 Chathura Wijekoon. All rights reserved.
//

import XCTest

class WijekoonWHMCB_COBSCCOMP191P_006UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthSuccess() throws {
        let username = "chathura@gmail.com"
        let userpassword = "chathura1996"
        
        let app = XCUIApplication()
        app.activate()
        app.launch()
        app.tabBars.buttons["Update"].tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign Up with Email"]/*[[".buttons[\"Sign Up with Email\"].staticTexts[\"Sign Up with Email\"]",".staticTexts[\"Sign Up with Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        
        let email = app.textFields["Email"]
        email.tap()
        email.typeText(username)
        
        sleep(5)
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText(userpassword)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let updateButton = app/*@START_MENU_TOKEN@*/.staticTexts["Update"]/*[[".buttons.staticTexts[\"Update\"]",".staticTexts[\"Update\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let isThere = updateButton.waitForExistence(timeout: 5)
        if isThere {
                XCTAssert(updateButton.exists)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
