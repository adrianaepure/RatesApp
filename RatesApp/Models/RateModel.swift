//
//  RateModel.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation



struct RateModel{
    var currency: String?
    var value: Double?
}

struct LatestRateModel: Codable {
    var base: Currency
    var date: String
    var rates: [String: Double]
}

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
