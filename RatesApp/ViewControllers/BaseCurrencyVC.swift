//
//  BaseCurrencyVC.swift
//  RatesApp
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

class BaseCurrencyVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        ///Mark the chosen base currency as selected
        if cell.reuseIdentifier == SharedSettings.shared.baseCurrency.rawValue {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            cell.accessoryType = .none
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        ///Mark the user selection currency as selected
        if let name = cell?.reuseIdentifier {
            if (SharedSettings.shared.baseCurrency.rawValue != name) {
                SharedSettings.shared.baseCurrency = Currency(rawValue: name)!
                cell?.accessoryType = .checkmark
            }
            
        }
        
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier != nil {
            cell?.accessoryType = .none
        }
            
    }
}
