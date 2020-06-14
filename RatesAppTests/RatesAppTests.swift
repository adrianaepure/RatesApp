//
//  RatesAppTests.swift
//  RatesAppTests
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import XCTest
@testable import RatesApp

class RatesAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFetchLatestRates() {
        RatesClient.shared.fetchLatestRates(for: Currency.EUR) { (response) in
            XCTAssertEqual(response?.rates.count, 3, "We should have loaded exactly 3 rates.")
            XCTAssertEqual(response?.base, Currency.EUR, "Base is euro.")
            
        }
        
    }
    func testLatestRatesVM(){
        let expectation = XCTestExpectation(description: "Get valid data")
        
        let vm = LatestRatesVM(baseCurrency: Currency.EUR)
        
        vm.getLatestRatesData {
            XCTAssertNotNil(vm.baseCurrency)
            expectation.fulfill()
        }
         // wait three seconds for all outstanding expectations to be fulfilled
          waitForExpectations(timeout: 3) { (error) in
               if let error = error {
                   XCTFail("timeout errored: \(error)")
               }
           }

           // our expectation has been fulfilled, so we can check the result is correct
        XCTAssertEqual(vm.rates?.count, 3, "We should have loaded exactly 3 rates.")

    }
}
