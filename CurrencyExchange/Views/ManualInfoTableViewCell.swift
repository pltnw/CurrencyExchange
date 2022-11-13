//
//  ManualInfoTableViewCell.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 13.11.2022.
//

import UIKit

class ManualInfoTableViewCell: UITableViewCell {

    @IBOutlet var coinName: UILabel!
    @IBOutlet var coinUnit: UILabel!
    @IBOutlet var coinValue: UILabel!
    @IBOutlet var coinType: UILabel!
    
    func configure(with info: Rate) {
        coinName.text = "Coin: \(info.name)"
        coinUnit.text = "Unit: \(info.unit)"
        coinValue.text = "Value: \(info.value.formatted())"
        coinType.text = "Type: \(info.type.rawValue)"
    }
}
