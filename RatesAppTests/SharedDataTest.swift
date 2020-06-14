//
//  SharedDataTest.swift
//  RatesAppTests
//
//  Created by Adriana Epure on 16/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import XCTest
@testable import RatesApp

class SharedDataTest: XCTestCase {


    func testChangeBaseCurrencyToRON() throws {
        
        let sharedData = SharedSettings.shared
        sharedData.baseCurrency = .RON
        XCTAssertEqual(sharedData.baseCurrency, .RON, "The base currency should have changed to RON.")
        
    }
    func testChangeRefreshTimeTo15() throws {
        
        let sharedData = SharedSettings.shared
        sharedData.refreshTime = "15"
        XCTAssertEqual(sharedData.refreshTime, "15", "The refresh time should have changed to.")
        
    }
    override class func tearDown() {
        //Change base currency to EUR and refresh time to 3seconds
        SharedSettings.shared.baseCurrency = .EUR
        SharedSettings.shared.refreshTime = "3"
        super.tearDown()
    }

}
