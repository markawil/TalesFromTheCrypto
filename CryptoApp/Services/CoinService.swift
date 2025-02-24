//
//  CoinService.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Combine
import Foundation

class CoinService {
    
    private let coingeckoPath = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false"
    
    @Published var allCoins: [Coin] = []
    
    private var coinSubscription: AnyCancellable?
    
    init() {
        loadCoins()
    }
    
    private func loadCoins() {
        
        guard let url = URL(string: coingeckoPath) else {
            fatalError("Invalid URL")
        }
        guard let bundlePath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: bundlePath) as? [String: AnyObject],
              let apiKey = dict["API_KEY"] as? String else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-cg-demo-api-key")
        
        coinSubscription = NetworkingManager.download(for: request)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] (coins) in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
