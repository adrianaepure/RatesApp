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
    
}
extension HistoryRatesVM {
    @objc func getHistoryRatesData() {
        RatesClient.shared.fetchHistoryRates() { (result, error) in
            guard let data = result else {return}
            let flattenedRates = data.rates.compactMap{$0}
            var ratesResult = [String:[ValueByDate]]()
            let allCurrenciesList = Array(Set(data.rates.values.flatMap({$0.keys}))).sorted(by: {$0 < $1})
            for currency in allCurrenciesList {
                let newVal = flattenedRates.reduce([ValueByDate](), { res, item in
                    var arr = res
                    arr.append(ValueByDate(date: item.key.convertStringToDate()!, value: (item.value[currency]?.rounded(toDecimalPlaces: 2))!))
                    arr.sort(){$0.date < $1.date}
                    return arr
                    
                })
                
                ratesResult.updateValue(newVal, forKey: currency)
                
            }
            self.rates = ratesResult
            self.delegate?.didFinishLoading()
            
        }
    }
    func getHistoryRates(for currency: String) -> ([String], [Double]){
        let dates = self.rates?[currency]?.compactMap{$0.date.customShortDateFormatter()}
        let values = self.rates?[currency]?.compactMap{$0.value}
        return (dates!,values!)
    }
}
