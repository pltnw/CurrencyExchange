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
    
//    private func fetchCoins() {
//        AF.request(Link.coinGecko.rawValue)
//            .responseJSON { dataResponse in
//                guard let statusCode = dataResponse.response?.statusCode else { return }
//
//                print("Status code: \(statusCode)")
//
//                if (200..<300).contains(statusCode) {
//                    guard let value = dataResponse.value else { return }
//                    print("Value: \(value)")
//
//                    return
//                }
//
//                guard let error = dataResponse.error else { return }
//                print("Error: \(error)")
//            }
//    }
    
    private func fetchCoins() {
        AF.request(Link.coinGecko.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let coinsData = value as? [String: Any] else { return }
//                    print(coinsData)
                    
                   let coin = Rate(
                            name: coinsData["name"] as? String ?? "",
                            unit: coinsData["unit"] as? String ?? "",
                            value: coinsData["value"] as? Double ?? 0,
                            type: coinsData["type"] as? TypeEnum ?? .crypto
                        )
                    
                    print(coin)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}

