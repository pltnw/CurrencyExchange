//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 06.11.2022.
//

import UIKit

enum Link: String {
    case imageURL = "https://s2.best-wallpaper.net/wallpaper/iphone/1709/Money-paper-currency_iphone_1080x1920.jpg"
    case coinGecko = "https://api.coingecko.com/api/v3/exchange_rates"
}

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
    case fetchCurrencyInformation = "Currency Information"
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in debug area"
        case .failed:
            return "You can see error in debug area"
        }
    }
}

class MainViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "userAction",
            for: indexPath
        )
        
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionsLabel.text = userActions[indexPath.item].rawValue
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .showImage:
            performSegue(withIdentifier: "showImage", sender: nil)
        case .fetchCurrencyInformation:
            fetchCurrencyInformation()
        }
    }
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: UIScreen.main.bounds.width - 50, height: 80)
    }
}

extension MainViewController {
    private func fetchCurrencyInformation(){
        guard let url = URL(string: Link.coinGecko.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let currency = try decoder.decode(Currencies.self, from: data)
                print(currency)
                self?.showAlert(withStatus: .success)
            } catch let error {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
        }.resume()
    }
}
