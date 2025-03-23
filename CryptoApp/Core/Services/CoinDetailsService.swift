//
//  CoinDetailsService.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/7/25.
//

import Combine
import Foundation

class CoinDetailsService {
    
    @Published var coinDetails: CoinDetails?
    
    private var detailsSubscription: AnyCancellable?
    
    init(coinId: String) {
        loadDetails(for: coinId)
    }
    
    func loadDetails(for coinID: String) {
        
        let detailsPath = "https://api.coingecko.com/api/v3/coins/\(coinID)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        guard let url = URL(string: detailsPath) else {
            fatalError("Invalid URL")
        }
        guard let apiKey = NetworkingManager.apiKey() else {
            fatalError("API Key not set")
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: apiKey_key)
        
        detailsSubscription = NetworkingManager.download(for: request)
            .decode(type: CoinDetails.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] (coinDetails) in
                self?.coinDetails = coinDetails
                self?.detailsSubscription?.cancel()
            })
    }
}

