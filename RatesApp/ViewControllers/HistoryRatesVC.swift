//
//  HistoryRatesVC.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

class HistoryRatesVC: UIViewController {
    private var vm = HistoryRatesVM(baseCurrency: Currency.EUR)
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getHistoryRatesData {
            print("CALLED FROM VC GET HISTORY RATES")
        }
    }
    

}
