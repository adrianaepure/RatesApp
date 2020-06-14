//
//  HistoryRatesModel.swift
//  RatesApp
//
//  Created by Adriana Epure on 16/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

/// Model  used to decode a JSON string of the following composition
///{
///rates: {
///2020-04-14: {
///BGN: 1.9558,
///RON: 4.8343,
///USD: 1.0963
///},
///start_at: "2020-04-06",
///base: "EUR",
///end_at: "2020-04-16"
///}
///Return a strurct with an Array of Date and Value Dictionaries grouped by currency
///
///

struct HistoryRates: Codable {
    var rates: [String: [String:Double]]
}
struct ValueByDate: Codable{
    var date: Date
    var value: Double
}

struct RateByDates: Codable {
    var currency: String!
    var rates: [ValueByDate]!
}
