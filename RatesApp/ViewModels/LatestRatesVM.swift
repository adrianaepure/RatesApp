//
//  LatestRatesVM.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation
import UIKit

//public protocol LatestRatesVMProtocol {
//
//    func getLatestRates(completion: () -> ())
//}

protocol LatestRatesVMDelegate {
    func didFinishLoading()
}

public class LatestRatesVM  {
    var baseCurrency: Currency
    var refreshRate: Double
    var date: String?
    var rates: Array<RateModel>?
    var delegate:  LatestRatesVMDelegate?
    var refreshTimer: Timer?
    init(baseCurrency: Currency, refreshRate: Double){
        self.baseCurrency = baseCurrency
        self.refreshRate = refreshRate
    }
    
    deinit {
        print("DEINIT LATEST Rates VM")
        self.refreshTimer?.invalidate()
    }
}
extension LatestRatesVM {
    @objc func getLatestRatesData() {
        RatesClient.shared.fetchLatestRates(for:baseCurrency) { (response) in
            guard let data = response else {return}
            self.date = Date().customDateFormatter()
            self.rates = data.rates.sorted(by:{ $0.key < $1.key}).compactMap {RateModel(currency: $0, value: $1)}
            self.delegate?.didFinishLoading()
            self.refreshLatestCurrencies(after:self.refreshRate)
            
        }
    }
    func currencyForItemAtIndexPath(index:IndexPath) -> String{
        return self.rates?[Int(index.row)].currency ?? ""
    }
    func valueForItemAtIndexPath(index:IndexPath) -> String{
        let value = self.rates?[Int(index.row)].value?.rounded(toDecimalPlaces: 2) ?? 0.0
        return String(value)
    }
    func numberOfRowsInSection(section: Int) -> Int{
        return self.rates?.count ?? 0
    }
    func getCurrencyImage(index:IndexPath) -> UIImage{
        return UIImage(named: self.rates?[Int(index.row)].currency ?? "EUR")!
    }
    func getLastUpdatedTimeTitle() -> String{
        if self.date != nil {
            return String("Last updated: \(self.date!)")
        }else{
            return "Fetching data ..."
        }
    }
    func getViewTitle() -> String{
        return String("Lates Rates for: \(self.baseCurrency)")
    }
    func refreshLatestCurrencies(after interval:Double){
        self.refreshTimer?.invalidate()
        self.refreshTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(getLatestRatesData), userInfo: nil, repeats: false)
        
    }
}
