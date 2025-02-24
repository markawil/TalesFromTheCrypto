//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var coins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    private let coinService = CoinService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        coinService.$allCoins
            .sink { [weak self] coins in
                self?.coins = coins
            }
            .store(in: &cancellables)
    }
}
