//
//  Reddit_Prototype_iOSUITests.swift
//  Reddit-Prototype-iOSUITests
//
//  Created by Basem Emara on 2020-12-11.
//

import XCTest

class Reddit_Prototype_iOSUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        // Ensure app starts
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch the app.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
