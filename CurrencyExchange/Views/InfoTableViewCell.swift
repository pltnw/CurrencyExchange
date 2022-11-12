//
//  InfoTableViewCell.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 12.11.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet var currencyName: UILabel!
    @IBOutlet var currencyUnit: UILabel!
    @IBOutlet var currencyValue: UILabel!
    @IBOutlet var currencyType: UILabel!
    
    func configure(with info: Rate) {
        currencyName.text = "Currency: \(info.name)"
        currencyUnit.text = "Unit: \(info.unit)"
        currencyValue.text = "Value: \(info.value.formatted())"
        currencyType.text = "Type: \(info.type.rawValue)"
    }

}
