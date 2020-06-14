//
//  ViewController.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

class LatestRatesVC: UIViewController {
    private var vm = LatestRatesVM(baseCurrency: Currency.EUR, refreshRate: 30.0)
    //    var delegate: LatestRatesVMDelegate?
    @IBOutlet weak var latestRatesTableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vm.delegate = self;
        self.title = vm.getViewTitle()
        // Do any additional setup after loading the view.
        reloadLatestCurrencyData()
    }
    func reloadLatestCurrencyData(){
        self.loadingActivityIndicator.startAnimating()        
        self.vm.getLatestRatesData()
    }
    
}
extension LatestRatesVC: LatestRatesVMDelegate{
    func didFinishLoading() {
        self.latestRatesTableView.reloadData()
        self.loadingActivityIndicator.stopAnimating()
        self.loadingActivityIndicator.hidesWhenStopped = true
    }
    
    
}
extension LatestRatesVC {
    
    @IBAction func refreshLatesRatesBtn(_ sender: UIBarButtonItem) {
        self.vm.getLatestRatesData()
    }
    @IBAction func showHistoryRatesBtn(_ sender: Any) {
    }
    @IBAction func changeRefreshIntervalBtn(_ sender: UIButton) {
        // Print out what button was tapped
        func updateRefreshInterval(_ action: UIAlertAction) {
            print("You tapped \(action.title!)")
            vm.refreshRate = Double("action.title") ?? 30.0
            reloadLatestCurrencyData()
        }
        let alertController = UIAlertController(title: "Refresh interval", message: "Select the desired refresh interval in seconds: ", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "30", style: .default, handler: updateRefreshInterval))
        alertController.addAction(UIAlertAction(title: "10", style: .default, handler: updateRefreshInterval))
        alertController.addAction(UIAlertAction(title: "5", style: .default, handler: updateRefreshInterval))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: updateRefreshInterval))
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func changeBaseCurrencyBtn(_ sender: UIButton) {
        // Print out what button was tapped
        func updateBaseCurrency(_ action: UIAlertAction) {
            print("You tapped \(action.title!)")
            self.title = vm.getViewTitle()
            vm.baseCurrency = Currency(rawValue: action.title!) ?? Currency.EUR
            reloadLatestCurrencyData()
        }
        let alertController = UIAlertController(title: "Base currency", message: "Choose the desired base currency", preferredStyle: .actionSheet)
        for currency in Currency.allCases{
            if vm.baseCurrency == currency {
                alertController.addAction(UIAlertAction(title: currency.rawValue, style: .destructive, handler: updateBaseCurrency))
            }else{
                
                alertController.addAction(UIAlertAction(title: currency.rawValue, style: .default, handler: updateBaseCurrency))
            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: updateBaseCurrency))
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
}
extension LatestRatesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("section: ", self.vm.numberOfRowsInSection(section: section))
        return self.vm.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestRateCell") as! LatestRateCell
        cell.currencyTitleLbl.text = self.vm.currencyForItemAtIndexPath(index: indexPath)
        cell.rateValueLbl.text = self.vm.valueForItemAtIndexPath(index: indexPath)
        cell.currencyImg.image = self.vm.getCurrencyImage(index: indexPath)
        print("cell stuff: ", cell.currencyTitleLbl.text!, cell.rateValueLbl.text!)
        return cell
    }
    //    /// Return the header section tiltle formatted with the selected base currency and last update time
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.vm.getLastUpdatedTimeTitle()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
