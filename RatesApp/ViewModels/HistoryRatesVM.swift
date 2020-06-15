//
//  HistoryRatesVM.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

protocol HistoryRatesVMDelegate {
    func didFinishLoading()
}



class HistoryRatesVM {
    var baseCurrency: Currency
    var rates: [String: [ValueByDate]]?
    var delegate:  HistoryRatesVMDelegate?
    init(baseCurrency: Currency){
        self.baseCurrency = baseCurrency
    }
    deinit {
        print("DEINIT History Rates VM")
    }
}
extension HistoryRatesVM {
    @objc func getHistoryRatesData() {
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
            self.delegate?.didFinishLoading()
            
        }
    }
    func getHistoryRates(for currency: String) -> ([String], [Double]){
        let dates = self.rates?[currency]?.compactMap{$0.date.customShortDateFormatter()}
        let values = self.rates?[currency]?.compactMap{$0.value}
        return (dates!,values!)
    }
}
