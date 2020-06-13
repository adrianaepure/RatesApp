//
//  ViewController.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

class LatestRatesVC: UIViewController {
    private var vm = LatestRatesVM(baseCurrency: Currency.EUR)
    private var vmHistory = HistoryRatesVM(baseCurrency: Currency.EUR)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm.getLatestRatesData {
            print("CALLED FROM VC GET LATEST RATES")
        }
        vmHistory.getHistoryRatesData {
                   print("CALLED FROM VC GET HISTORY RATES")
               }
    }


}

