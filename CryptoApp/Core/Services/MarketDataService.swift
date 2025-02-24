//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/24/25.
//

import Combine
import Foundation

class MarketDataService {
    
    private let marketDataPath = "https://api.coingecko.com/api/v3/global"
    
    @Published var marketData: MarketData?
    
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        loadData()
    }
    
    private func loadData() {
        
        guard let url = URL(string: marketDataPath) else {
            fatalError("Invalid URL")
        }
        guard let apiKey = NetworkingManager.apiKey() else {
            fatalError("API Key not set")
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: apiKey_key)
        
        marketDataSubscription = NetworkingManager.download(for: request)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] (globalData) in
                self?.marketData = globalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
