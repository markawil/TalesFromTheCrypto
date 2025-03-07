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
    @Published var searchText: String = ""
    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChange: -7),
    ]
    
    // Services
    private let coinService = CoinService()
    private let marketService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    private var hasInitialized = false
    
    init() {
        addSubscribers()
        self.hasInitialized = true
    }
    
    func addSubscribers() {
        guard !hasInitialized else { return }
        
        // Update the coins the user wants to see
        // anytime either publisher changes this is going to be sinked
        $searchText
            .combineLatest(coinService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.coins = coins
            }
            .store(in: &cancellables)
        
        // Update the Market Data statistics
        marketService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellables)
        
        // Updates the user's portfolio coins page
        $coins // filtered coins from search
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, savedEntities) -> [Coin] in
                coins.compactMap { (coin) -> Coin? in
                    guard let entity = savedEntities.first(where: { $0.coinId == coin.id }) else { return nil }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] coins in
                self?.portfolioCoins = coins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(text.lowercased()) ||
                coin.symbol.lowercased().contains(text.lowercased()) ||
                coin.id.lowercased().contains(text.lowercased())
        }
    }
    
    private func mapGlobalMarketData(data: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = data else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24H Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "$0.0", percentageChange: 0.0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
}
