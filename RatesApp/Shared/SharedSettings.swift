//
//  SharedSettings.swift
//  RatesApp
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation


///Class that holds the user settings for base currency and refresh time
///By default the base currency is EURO and refresh time is 3 seconds
public class SharedSettings: NSObject {
    static let shared = SharedSettings()
    
    var baseCurrency: Currency = Currency.EUR
    var refreshTime: String = "3"
    
}
