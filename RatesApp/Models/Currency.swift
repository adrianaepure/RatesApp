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
//    func getName() -> String {
//        switch self {
//        case .EUR:
//            return "Euro"
//        case .USD:
//            return "US Dollar"
//        case .BGN:
//            return "Bulgarian Leva"
//        case .RON:
//            return "Romanian Leu"
//        }
//    }
}
