//
//  ViewController.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

class LatestRatesVC: UIViewController {
    
    private var vm = LatestRatesVM()
    @IBOutlet weak var latestRatesTableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init latest vm")
        self.vm.delegate = self;
    }
    override func viewWillAppear(_ animated: Bool) {        
        self.title = vm.getViewTitle()
        loadLatestCurrencyData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.vm.invalidateTimer()
    }
}
//MARK: - Controller Methods
extension LatestRatesVC {
    func loadLatestCurrencyData(){
        self.loadingActivityIndicator.startAnimating()
        self.vm.getLatestRatesData()
    }
}

//MARK: - View Model Delegate
extension LatestRatesVC: LatestRatesVMDelegate{
    func didFinishLoading() {
        self.latestRatesTableView.reloadData()
        self.loadingActivityIndicator.stopAnimating()
        self.loadingActivityIndicator.hidesWhenStopped = true
    }
    
    
}
//MARK: - Action functions
extension LatestRatesVC {
    
    @IBAction func refreshLatesRatesBtn(_ sender: UIBarButtonItem) {
        self.vm.getLatestRatesData()
    }
    @IBAction func showHistoryRatesBtn(_ sender: Any) {
    }
    
}
//MARK: - Table View Delegate
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.vm.getLastUpdatedTimeTitle()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
