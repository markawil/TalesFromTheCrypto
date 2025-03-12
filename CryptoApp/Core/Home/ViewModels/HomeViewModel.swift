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
    @Published var statistics: [Statistics] = []
    @Published var currentSortOption: CoinSortOptions = .holdings
    
    // Dependencies
    private let coinService: CoinService
    private let marketDataService: MarketDataService
    private let portfolioDataService: PortfolioDataService
    
    private var cancellables = Set<AnyCancellable>()
    private var hasInitialized = false
    
    init(coinService: CoinService = CoinService(),
         marketService: MarketDataService = MarketDataService(),
         portfolioDataService: PortfolioDataService = PortfolioDataService()) {
        
        self.coinService = coinService
        self.marketDataService = marketService
        self.portfolioDataService = portfolioDataService
        
        setupCombine()
        self.hasInitialized = true
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    func reloadData() {
        coinService.loadCoins()
        marketDataService.loadData()
        HapticManager.notification(.success)
    }
    
    private func setupCombine() {
        guard !hasInitialized else { return }
        
        // Update the coins the user wants to see
        // anytime either publisher changes this is going to be sinked
        $searchText
            .combineLatest(coinService.$allCoins, $currentSortOption)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] coins in
                self?.coins = coins
            }
            .store(in: &cancellables)
        
        // Updates the user's portfolio coins page
        $coins // filtered coins from search
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapCoinsToPortfolioCoins)
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.portfolioCoins = coins.sortOnHoldings(sortOption: currentSortOption)
            }
            .store(in: &cancellables)
        
        // Update the Market Data statistics
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellables)
    }
    
    private func filterAndSortCoins(text: String, coins: [Coin], sortOption: CoinSortOptions) -> [Coin] {
        let filteredCoins = filterCoins(text: text, coins: coins)
        return filteredCoins.sort(on: sortOption)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let filteredCoins = coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(text.lowercased()) ||
                coin.symbol.lowercased().contains(text.lowercased()) ||
                coin.id.lowercased().contains(text.lowercased())
        }
        
        return filteredCoins
    }
    
    private func mapCoinsToPortfolioCoins(coins: [Coin], savedEntities: [PortfolioEntity]) -> [Coin] {
        coins.compactMap { (coin) -> Coin? in
            guard let entity = savedEntities.first(where: { $0.coinId == coin.id }) else { return nil }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(data: MarketData?, coins: [Coin]) -> [Statistics] {
        var stats: [Statistics] = []
        guard let data = data else {
            return stats
        }
        
        let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistics(title: "24H Volume", value: data.volume)
        let btcDominance = Statistics(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentChange = ((portfolioValue - previousValue)/previousValue) * 100
        let percentValueToShow = percentChange.isNaN ? 0.0 : percentChange
        
        let portfolio = Statistics(title: "Portfolio Value",
                                  value: portfolioValue.currencyWith2Decimals(),
                                  percentageChange: percentValueToShow)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
}

extension Array where Element == Coin {
    
    func sort(on sortOption: CoinSortOptions) -> [Coin] {
        switch sortOption {
        case .rank, .holdings:
            return self.sorted(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            return self.sorted(by: { $0.rank > $1.rank })
        case .price:
            return self.sorted(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            return self.sorted(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    func sortOnHoldings(sortOption: CoinSortOptions) -> [Coin] {
        switch sortOption {
        case .holdings:
            return self.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return self.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return self
        }
    }
}
