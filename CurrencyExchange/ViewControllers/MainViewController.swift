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
    
        return cell
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
