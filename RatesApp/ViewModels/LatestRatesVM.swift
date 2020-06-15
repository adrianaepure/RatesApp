//
//  LatestRatesVM.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation
import UIKit

protocol LatestRatesVMDelegate {
    func didFinishLoading()
}

public class LatestRatesVM  {
    var date: String?
    var rates: Array<RateModel>?
    var delegate:  LatestRatesVMDelegate?
    var refreshTimer: Timer?
    init(){}
}
extension LatestRatesVM {
    @objc func getLatestRatesData() {
        RatesClient.shared.fetchLatestRates() { (result, error) in
            guard let data = result else {return}
            self.date = Date().customDateFormatter()
            self.rates = data.rates.sorted(by:{ $0.key < $1.key}).compactMap {RateModel(currency: $0, value: $1)}
            self.delegate?.didFinishLoading()
            self.refreshLatestCurrencies()
            
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
        return String("Lates Rates for: \(SharedSettings.shared.baseCurrency)")
    }
    func refreshLatestCurrencies(){
        self.invalidateTimer()
        let refreshInterval =  Double(SharedSettings.shared.refreshTime) ?? 15.0
        self.refreshTimer = Timer.scheduledTimer(timeInterval: refreshInterval, target: self, selector: #selector(getLatestRatesData), userInfo: nil, repeats: false)
        
    }
    func invalidateTimer(){
        self.refreshTimer?.invalidate()
    }
}
