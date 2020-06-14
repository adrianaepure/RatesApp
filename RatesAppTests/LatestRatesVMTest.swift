//
//  LatestRatesVMTest.swift
//  RatesAppTests
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import XCTest
@testable import RatesApp

class LatestRatesVMTest: XCTestCase, LatestRatesVMDelegate {
    
    private var expectation: XCTestExpectation!

    func testInitialization() {
        
        // Initialize Profile View Model
        let latestRatesVM = LatestRatesVM()
        XCTAssertNotNil(latestRatesVM, "The latest rates view model should not be nil.")
        
    }
    func testDelegateCalled(){
        
        expectation = expectation(description: "The Latest Rates view model should fetch data")
        // Initialize Profile View Model
        let latestRatesVM = LatestRatesVM()
        latestRatesVM.delegate = self
        latestRatesVM.getLatestRatesData()
        waitForExpectations(timeout: 20)
    }
    func didFinishLoading() {
        expectation.fulfill()
    }

}
