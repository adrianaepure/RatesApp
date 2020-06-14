//
//  RefreshIntervalVC.swift
//  RatesApp
//
//  Created by Adriana Epure on 15/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit

class RefreshIntervalVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        ///Mark the chosen refresh time as selected
        if cell.reuseIdentifier == SharedSettings.shared.refreshTime {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            cell.accessoryType = .none
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let name = cell?.reuseIdentifier {
             ///Mark the user selection refresh time as selected
            if (SharedSettings.shared.refreshTime != name) {
                SharedSettings.shared.refreshTime = name
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
