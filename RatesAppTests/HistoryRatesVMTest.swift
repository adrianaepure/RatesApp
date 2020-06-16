//
//  HistoryRatesVMTest.swift
//  RatesAppTests
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import XCTest
@testable import RatesApp

class HistoryRatesVMTest: XCTestCase, HistoryRatesVMDelegate {
    
    private var expectation: XCTestExpectation!

    func testInitialization() {
        
        // Initialize Profile View Model
        let historyRatestVM = HistoryRatesVM()
        XCTAssertNotNil(historyRatestVM, "The history Rates view model should not be nil.")
        
    }
    func testDelegateCalled(){
        
        expectation = expectation(description: "The history Rates view model should fetch data")
        // Initialize Profile View Model
        let historyRatestVM = HistoryRatesVM()
        historyRatestVM.delegate = self
        historyRatestVM.getHistoryRatesData()
        waitForExpectations(timeout: 20)
    }
    func didFinishLoading() {
        expectation.fulfill()
    }

}
