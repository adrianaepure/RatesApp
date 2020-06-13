//
//  LatestRatesVM.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

//public protocol LatestRatesVMProtocol {
//
//    func getLatestRates(completion: () -> ())
//}

class LatestRatesVM  {
    var baseCurrency: Currency
    var date: Date!
    var rates: Array<RateModel>?
    init(baseCurrency: Currency){
        self.baseCurrency = baseCurrency
    }
    
    deinit {
        print("DEINIT LATEST Rates VM")
    }
}
extension LatestRatesVM {
    func getLatestRatesData(completion: () -> ()) {
        RatesClient.shared.fetchLatestRates(for: Currency.EUR) { (response) in
            guard let data = response else {return}
            self.date = data.date.convertStringToDate()
            let indexPath = IndexPath(row: 0, section: 0)
            self.rates = data.rates.compactMap {RateModel(currency: $0, value: $1)}
            print(self.currencyForItemAtIndexPath(index: indexPath))
            print(self.valueForItemAtIndexPath(index: indexPath))
            
        }
    }
    func currencyForItemAtIndexPath(index:IndexPath) -> String{
        return self.rates?[Int(index.row)].currency ?? ""
    }
    func valueForItemAtIndexPath(index:IndexPath) -> Double{
        return self.rates?[Int(index.row)].value?.rounded(toDecimalPlaces: 2) ?? 0.0
    }
    func numberOfItemsInSection(section: Int) -> Int{
        return self.rates?.count ?? 0
    }
    
}
