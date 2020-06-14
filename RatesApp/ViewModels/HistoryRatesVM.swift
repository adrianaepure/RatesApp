//
//  HistoryRatesVM.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

class HistoryRatesVM {
    var baseCurrency: Currency
    var rates: [String: [ValueByDate]]?
    init(baseCurrency: Currency){
        self.baseCurrency = baseCurrency
    }
    deinit {
        print("DEINIT History Rates VM")
    }
}
extension HistoryRatesVM {
    func getHistoryRatesData(completion: () -> ()) {
        RatesClient.shared.fetchHistoryRates(for: Currency.EUR) { (rates) in
            guard let response = rates else {return}
            let flattenedRates = response.rates.compactMap{$0}
            var result = [String:[ValueByDate]]()
            let allCurrenciesList = Array(Set(response.rates.values.flatMap({$0.keys}))).sorted(by: {$0 < $1})
            for currency in allCurrenciesList {
                let newVal = flattenedRates.reduce([ValueByDate](), { res, item in
                    var arr = res
                    arr.append(ValueByDate(date: item.key.convertStringToDate()!, value: (item.value[currency]?.rounded(toDecimalPlaces: 2))!))
                    return arr
                    
                })
                result.updateValue(newVal, forKey: currency)
                
            }
            self.rates = result
//            print("Historical Rates for USD", self.getHistoryRates(for: "USD")!)
//            print("Historical Rates for RON", self.getHistoryRates(for: "RON")!)
            
        }
    }
    func getHistoryRates(for currency: String) -> [ValueByDate]?{
        return self.rates?[currency] ?? nil
    }
}
