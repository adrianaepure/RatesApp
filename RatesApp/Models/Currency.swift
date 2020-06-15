//
//  Currency.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

public enum Currency: String, Codable, CaseIterable {
    case EUR
    case RON
    case BGN
    case USD
    func displayName() -> String {
        switch self {
        case .EUR:
            return "Euro"
        case .USD:
            return "US Dollar"
        case .BGN:
            return "Bulgarian Leva"
        case .RON:
            return "Romanian Leu"
        }
    }
    func getRemainingCurrenciesString() -> String {
           var curenciesArray = Currency.allCases.map{$0.rawValue}
           curenciesArray = curenciesArray.filter{$0 != self.rawValue}
           return curenciesArray.joined(separator: ",")
       }
    func getRemainingCurrenciesArray() -> Array<Currency> {
           let curenciesArray = Currency.allCases.map{$0}
           return curenciesArray.filter{$0 != self}
       }
}
