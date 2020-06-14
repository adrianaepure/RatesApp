//
//  RatesClient.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

public class RatesClient: NSObject {
    static let shared = RatesClient()
    
}
extension RatesClient{
    ///fetch latest rates data and call the completion block
    func fetchLatestRates(completion:@escaping (_ result:LatestRateModel?, _ error: NSError?) -> ()){
        let service = WebServiceManager()
        let base = SharedSettings.shared.baseCurrency
        let otherSymbolsString = base.getRemainingCurrenciesString()
        let parameters = ["base":base.rawValue, "symbols":otherSymbolsString];
        service.fetchData(for: Constants.APIPaths.latestPath!, params: parameters) { (response: LatestRateModel?, error: Error?) in
            if let data = response {
                completion(data, nil)
            }
            if error != nil {
                completion(nil, error as NSError?)
            }
        }
    }
     ///fetch history rates data and call the completion block
    func fetchHistoryRates(completion:@escaping (_ result:HistoryRates?, _ error: NSError?) -> ()){
        let service = WebServiceManager()
        let base = SharedSettings.shared.baseCurrency
        let otherSymbolsString = base.getRemainingCurrenciesString()
        let endAt = Date().customMediumDateFormatter()
        let startAt = Calendar.current.date(byAdding: .day, value: -10, to: Date())!.customMediumDateFormatter()
        let parameters = ["base":base, "start_at":startAt!, "end_at":endAt!, "symbols":otherSymbolsString] as [String : Any];
        service.fetchData(for: Constants.APIPaths.historyPath!, params: parameters) { (response: HistoryRates?, error: Error?) in
            if let data = response {
                completion(data, nil)
            }
            if error != nil {
                completion(nil, error as NSError?)
            }
        }
    }
}

