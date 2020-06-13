//
//  RatesClient.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

struct APIPaths {
    static let latestPath = URL(string: "https://api.exchangeratesapi.io/latest")
    static let historyPath = URL(string: "https://api.exchangeratesapi.io/history")
}
class RatesClient: NSObject {
    static let shared = RatesClient()
    
}
extension RatesClient{
    func fetchLatestRates(for base: Currency, completion:@escaping (_ rates:LatestRateModel?) -> ()){
        //        fetch data
        //call the completion block
        let service = WebServiceManager()
        let parameters = ["base":"EUR", "symbols":"USD,RON,BGN"];
        service.fetchData(for: APIPaths.latestPath!, params: parameters) { (response: LatestRateModel?, error: Error?) in
            if let data = response {
                print("Rates Client", data)
                completion(data)
            }
            if let err = error {
                debugPrint(err)
            }
        }
    }
    func fetchHistoryRates(for base: Currency, completion:@escaping (_ rates:HistoryRates?) -> ()){
        let service = WebServiceManager()
        let parameters = ["base":"EUR", "start_at":"2018-01-01", "end_at":"2018-01-10", "symbols":"USD,RON,BGN"];
        service.fetchData(for: APIPaths.historyPath!, params: parameters) { (response: HistoryRates?, error: Error?) in
            if let data = response {
                print("Rates Client", data)
                completion(data)
            }
            if let err = error {
                debugPrint(err)
            }
        }
    }
}
