//
//  TessafoldTestUITests.swift
//  TessafoldTestUITests
//
//  Created by Ali jaber on 25/04/2021.
//

import XCTest

class TessafoldTestUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
        
    }

  

    func testAppFlow() {
        
    }

}
