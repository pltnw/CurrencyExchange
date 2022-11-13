//
//  NetworkManager.swift
//  CurrencyExchange
//
//  Created by Екатерина Платонова on 13.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case imageURL = "https://s2.best-wallpaper.net/wallpaper/iphone/1709/Money-paper-currency_iphone_1080x1920.jpg"
    case coinGecko = "https://api.coingecko.com/api/v3/exchange_rates"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
}
