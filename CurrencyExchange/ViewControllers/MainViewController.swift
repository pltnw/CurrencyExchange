//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 06.11.2022.
//

import UIKit

enum UserAction: String, CaseIterable {
    case showImage = "Show image"
    case fetchCurrencyInformation = "Show info in debug area"
    case showCurrencyInformation = "Show information"
    case manualParsing = "Manual parsing"
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
        case .showCurrencyInformation:
            performSegue(withIdentifier: "showInfo", sender: nil)
        case .manualParsing:
            performSegue(withIdentifier: "showManualResults", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            guard let infoCurrencysVS = segue.destination as? InfoCurrencyTableViewController else { return }
            infoCurrencysVS.fetchCurrencyInformation()
        }
        if segue.identifier == "showManualResults" {
            guard segue.destination is ManualInfoTableViewController else { return }
        }
    }
    
    private func showAlert(withStatus status: Alert) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
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
    private func fetchCurrencyInformation() {
        NetworkManager.shared.fetchCurrencys(from: Link.coinGecko.rawValue) { [weak self] result in
            switch result {
            case .success(let currencys):
                print(currencys)
                self?.showAlert(withStatus: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
        }
    }
}
