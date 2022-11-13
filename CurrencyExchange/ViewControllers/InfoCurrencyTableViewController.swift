//
//  InfoCurrencyTableViewController.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 12.11.2022.
//

import UIKit

class InfoCurrencyTableViewController: UITableViewController {

    private var currencys = Currencies(rates: [String : Rate]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencys.rates.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        guard let cell = cell as? InfoTableViewCell else { return UITableViewCell() }

        let currency = Array(currencys.rates.values)[indexPath.row]
        
        cell.configure(with: currency)

        return cell
    }
}

//extension InfoCurrencyTableViewController {
//    func fetchCurrencyInformation() {
//        guard let url = URL(string: Link.coinGecko.rawValue) else { return }
//
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                self?.currencys = try JSONDecoder().decode(Currencies.self, from: data)
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//}


extension InfoCurrencyTableViewController {
    func fetchCurrencyInformation() {
        NetworkManager.shared.fetchCurrencys(from: Link.coinGecko.rawValue) { [weak self] result in
            switch result {
            case .success(let currencys):
                print(currencys)
                self?.currencys = currencys
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
