//
//  ManualInfoTableViewController.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 13.11.2022.
//

import UIKit

class ManualInfoTableViewController: UITableViewController {

    private var currencys = Currencies(rates: [String : Rate]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        fetchCoins()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        currencys.rates.count
        10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manualInfoCell", for: indexPath)
        guard let cell = cell as? ManualInfoTableViewCell else { return UITableViewCell() }

//        let currency = Array(currencys.rates.values)[indexPath.row]
//
//        cell.configure(with: currency)

        return cell
    }
    
    private func fetchCoins() {
        
    }
}

