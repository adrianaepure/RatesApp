//
//  LatestRatesModel.swift
//  RatesApp
//
//  Created by Adriana Epure on 16/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

/// Model  used to decode a JSON string of the following composition
///{
///  "rates": {
///    "BGN": 1.9558,
///    "RON": 4.8378,
///    "USD": 1.0903
///  },
///  "base": "EUR",
///  "date": "2020-04-15"
///}
///Return a strurct with an Array of Rates Dictionaries
///
///
struct LatestRateModel: Codable {
    var base: Currency
    var date: String
    var rates: [String: Double]
}
