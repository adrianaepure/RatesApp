//
//  CustomDateFormatter.swift
//  RatesApp
//
//  Created by Adriana Epure on 14/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation


extension Date {
    func customDateFormatter() -> String? {
        // initialize the date formatter and set the style
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long

        // get the date time String from the date object
        return dateFormatter.string(from: self)
    }
}
