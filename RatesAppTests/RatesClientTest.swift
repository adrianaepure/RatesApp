//
//  RatesAppTests.swift
//  RatesAppTests
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import XCTest
@testable import RatesApp

class RatesClientTest: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        //change the base currency to RON
        SharedSettings.shared.baseCurrency = .RON
    }
    
    func testFetchLatestRatesForRON() {
      let ex = expectation(description: "Expecting a JSON data not nil")

      RatesClient.shared.fetchLatestRates{ (result, error) in

        XCTAssertNil(error)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.rates.count, 3, "We should have loaded exactly 3 rates.")
        XCTAssertEqual(result?.base, Currency.RON, "Base is RON.")
        ex.fulfill()

      }

      waitForExpectations(timeout: 10) { (error) in
        if let error = error {
          XCTFail("error: \(error)")
        }
      }
    }
    func testFetchHistoryRatesForRON() {
      let ex = expectation(description: "Expecting a JSON data not nil")

      RatesClient.shared.fetchHistoryRates{ (result, error) in
        XCTAssertNil(error)
        XCTAssertNotNil(result)
        ex.fulfill()

      }

      waitForExpectations(timeout: 10) { (error) in
        if let error = error {
          XCTFail("error: \(error)")
        }
      }
    }
    
    override class func tearDown() {
        //Change base currency to EUR
        SharedSettings.shared.baseCurrency = .EUR
        super.tearDown()
    }
}
