//
//  SharedSettings.swift
//  RatesApp
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

public class SharedSettings: NSObject {
    static let shared = SharedSettings()
    
    var baseCurrency: Currency = Currency.EUR
    var refreshTime: String = "3"
    
}
