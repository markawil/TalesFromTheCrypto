//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var coins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.coins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        })
    }
}
