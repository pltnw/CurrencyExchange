//
//  ManualInfoTableViewController.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 13.11.2022.
//

import UIKit
import Alamofire

class ManualInfoTableViewController: UITableViewController {

    private var currencys = Currencies(rates: [String : Rate]())
//    private var coins: [Rate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        fetchCoins()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencys.rates.count
//        coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manualInfoCell", for: indexPath)
        guard let cell = cell as? ManualInfoTableViewCell else { return UITableViewCell() }

        let currency = Array(currencys.rates.values)[indexPath.row]

        cell.configure(with: currency)
        
        
//        let coinCell = coins[indexPath.row]
//        cell.configure(with: coinCell)

        return cell
    }
    
    private func fetchCoins() {
        AF.request(Link.coinGecko.rawValue)
            .validate()
            .responseJSON { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let coinsData = value as? [String: Any] else { return }
                    print("Value of JSON: \(coinsData)")
                    
                    let coin = Currencies(rates: ["rates": Rate(
                        name: coinsData["name"] as? String ?? "",
                        unit: coinsData["unit"] as? String ?? "",
                        value: coinsData["value"] as? Double ?? 0,
                        type: coinsData["type"] as? TypeEnum ?? .crypto
                    )])
                    
                    print(coin)
                    
                    self?.currencys = coin
                    
                    
//                    let coin = Rate(
//                            name: coinsData["name"] as? String ?? "",
//                            unit: coinsData["unit"] as? String ?? "",
//                            value: coinsData["value"] as? Double ?? 0,
//                            type: coinsData["type"] as? TypeEnum ?? .crypto
//                        )
//                    self?.coins.append(coin)

                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
}

