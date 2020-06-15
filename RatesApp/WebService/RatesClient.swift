//
//  RatesClient.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit
//
//struct APIPaths {
//    static let latestPath = URL(string: "https://api.exchangeratesapi.io/latest")
//    static let historyPath = URL(string: "https://api.exchangeratesapi.io/history")
//}
public class RatesClient: NSObject {
    static let shared = RatesClient()
    
}
extension RatesClient{
    func fetchLatestRates(completion:@escaping (_ rates:LatestRateModel?) -> ()){
        //        fetch data
        //call the completion block
        let service = WebServiceManager()
        let base = SharedSettings.shared.baseCurrency
        let otherSymbolsString = base.getRemainingCurrenciesString()
        let parameters = ["base":base.rawValue, "symbols":otherSymbolsString];
        service.fetchData(for: Constants.APIPaths.latestPath!, params: parameters) { (response: LatestRateModel?, error: Error?) in
            if let data = response {
                completion(data)
            }
            if let err = error {
                debugPrint(err)
            }
        }
    }
    func fetchHistoryRates(for base: Currency, completion:@escaping (_ rates:HistoryRates?) -> ()){
        let service = WebServiceManager()
        let otherSymbolsString = base.getRemainingCurrenciesString()
        let parameters = ["base":"EUR", "start_at":"2018-01-01", "end_at":"2018-01-10", "symbols":otherSymbolsString];
        service.fetchData(for: Constants.APIPaths.historyPath!, params: parameters) { (response: HistoryRates?, error: Error?) in
            if let data = response {
                completion(data)
            }
            if let err = error {
                debugPrint(err)
            }
        }
    }
}
class MyError: NSObject, LocalizedError {
    var desc = ""
    init(str: String) {
        desc = str
    }
    override var description: String {
        get {
            return "MyError: \(desc)"
        }
    }
    //You need to implement `errorDescription`, not `localizedDescription`.
    var errorDescription: String? {
        get {
            return self.description
        }
    }
}
