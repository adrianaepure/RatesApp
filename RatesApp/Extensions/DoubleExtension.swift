//
//  DoubleExtension.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toDecimalPlaces n: Int) -> Double {
        let multiplier = pow(10, Double(n))
        return (multiplier * self).rounded()/multiplier
    }
    func formatedString() -> String {
        return String(self.rounded(toDecimalPlaces: 0))
    }
}
