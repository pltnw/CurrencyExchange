//
//  CoinGecko.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 06.11.2022.
//

struct Currencies: Decodable {
    let rates: [String: Rate]
}

struct Rate: Decodable {
    let name: String
    let unit: String
    let value: Double
    let type: TypeEnum
}

enum TypeEnum: String, Decodable {
    case commodity = "commodity"
    case crypto = "crypto"
    case fiat = "fiat"
}
