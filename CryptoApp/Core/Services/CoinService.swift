//
//  CoinService.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Combine
import Foundation

let apiKey_key = "x-cg-demo-api-key"

class CoinService {
    
    private let coinsPath = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true"
    
    @Published var allCoins: [Coin] = []
    
    private var coinSubscription: AnyCancellable?
    
    init() {
        loadCoins()
    }
    
    func loadCoins() {
        
        guard let url = URL(string: coinsPath) else {
            fatalError("Invalid URL")
        }
        guard let apiKey = NetworkingManager.apiKey() else {
            fatalError("API Key not set")
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: apiKey_key)
        
        coinSubscription = NetworkingManager.download(for: request)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] (coins) in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
