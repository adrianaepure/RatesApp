//
//  LatestRatesVM.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation
import UIKit

//MARK: -  LatestRatesVMDelegate protocol
protocol LatestRatesVMDelegate {
    func didFinishLoading()
}
//MARK: - LatestRatesVM class
public class LatestRatesVM  {
    var date: String?
    var rates: Array<RateModel>?
    var delegate:  LatestRatesVMDelegate?
    var refreshTimer: Timer?
    init(){}
}

//MARK: -  LatestRatesVM methods
extension LatestRatesVM {
    ///fetch latest rates data and send an update when the request is finished
    @objc func getLatestRatesData() {
        self.date = nil
        RatesClient.shared.fetchLatestRates() { (result, error) in
            guard let data = result else {return}
            self.date = Date().customDateFormatter()
            self.rates = data.rates.sorted(by:{ $0.key < $1.key}).compactMap {RateModel(currency: $0, value: $1)}
            self.delegate?.didFinishLoading()
            self.refreshLatestCurrencies()
            
        }
    }
    ///method used to get cell currency title in LatestRatesVC
    func currencyForItemAtIndexPath(index:IndexPath) -> String{
        return self.rates?[Int(index.row)].currency ?? ""
    }
     ///method used to get cell currency value in LatestRatesVC
    func valueForItemAtIndexPath(index:IndexPath) -> String{
        let value = self.rates?[Int(index.row)].value?.rounded(toDecimalPlaces: 2) ?? 0.0
        return String(value)
    }
     ///method used to get the total number of rows of the table view in LatestRatesVC
    func numberOfRowsInSection(section: Int) -> Int{
        return self.rates?.count ?? 0
    }
     ///method used to get cell currency image  in LatestRatesVC
    func getCurrencyImage(index:IndexPath) -> UIImage{
        return UIImage(named: self.rates?[Int(index.row)].currency ?? "EUR")!
    }
    ///method used to get the update state title in LatestRatesVC
    func getLastUpdatedTimeTitle() -> String{
        if self.date != nil {
            return String("Last updated: \(self.date!)")
        }else{
            return "Fetching data ..."
        }
    }
     ///method used to get the view title for the chosen base currency in LatestRatesVC
    func getViewTitle() -> String{
        return String("Lates Rates for: \(SharedSettings.shared.baseCurrency)")
    }
     ///method used for creating a timer to start fetching data again at the chosen refresh time
    func refreshLatestCurrencies(){
        self.invalidateTimer()
        let refreshInterval =  Double(SharedSettings.shared.refreshTime) ?? 15.0
        self.refreshTimer = Timer.scheduledTimer(timeInterval: refreshInterval, target: self, selector: #selector(getLatestRatesData), userInfo: nil, repeats: false)
        
    }
     ///method used to invalidate the existing timer
    func invalidateTimer(){
        self.refreshTimer?.invalidate()
    }
}
