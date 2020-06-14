//
//  Constants.swift
//  RatesApp
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

///Application Constants enum

enum Constants {
    ///api paths for latest rates and history rates requests
    enum APIPaths {
        static let latestPath = URL(string: "https://api.exchangeratesapi.io/latest")
        static let historyPath = URL(string: "https://api.exchangeratesapi.io/history")
    }
}
