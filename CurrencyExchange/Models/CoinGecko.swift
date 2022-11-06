//
//  CoinGecko.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 06.11.2022.
//

struct Welcome: Codable {
    let rates: [String: Rate]
}

struct Rate: Codable {
    let name: String
    let unit: String
    let value: Double
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case commodity = "commodity"
    case crypto = "crypto"
    case fiat = "fiat"
}
