//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/6/25.
//

import Combine
import Foundation

class CoinDetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [Statistics] = []
    @Published var additionalStatistics: [Statistics] = []
    @Published var coinDescription: String?
    @Published var websiteURL: URL?
    @Published var redditURL: URL?
    
    let coinService: CoinDetailsService
    @Published var coin: Coin
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinService = CoinDetailsService(coinId: coin.id)
        setupCombine()
    }
    
    private func setupCombine() {
        
        coinService
            .$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (overviewStatistics, additionalStatistics) in
                self?.overviewStatistics = overviewStatistics
                self?.additionalStatistics = additionalStatistics
            }
            .store(in: &cancellables)
        
        coinService
            .$coinDetails
            .sink { [weak self] details in
                self?.coinDescription = details?.readableDescription
                self?.websiteURL = URL(string: details?.links?.homepage?.first ?? "")
                self?.redditURL = URL(string: details?.links?.subredditURL ?? "")
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetails: CoinDetails?, coin: Coin) -> (overview: [Statistics], additional: [Statistics]) {
        
        let overviewStatistics = createOverviewStatistics(coin: coin)
        let additionalStatistics = createAdditionalStatistics(coinDetails: coinDetails)
        
        return (overviewStatistics, additionalStatistics)
    }
    
    func createOverviewStatistics(coin: Coin) -> [Statistics] {
        
        // set the overview array
        let price = coin.currentPrice.currencyWith6Decimals()
        let currentPriceChange = coin.priceChangePercentage24H
        let priceStat = Statistics(title: "Current Price", value: price, percentageChange: currentPriceChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistics(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistics(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistics(title: "Volume", value: volume)
        
        let overviewArray = [priceStat, marketCapStat, rankStat, volumeStat]
        return overviewArray
    }
    
    func createAdditionalStatistics(coinDetails: CoinDetails?) -> [Statistics] {
        
        // additional
        let high = coin.high24H?.currencyWith6Decimals() ?? "n/a"
        let highStat = Statistics(title: "24h High", value: high)
        
        let low = coin.low24H?.currencyWith6Decimals() ?? "n/a"
        let lowStat = Statistics(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.currencyWith6Decimals() ?? "n/a"
        let priceChangePercentage = coin.priceChangePercentage24H
        let priceChangeStat = Statistics(title: "24h Price Change", value: priceChange, percentageChange: priceChangePercentage)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage24H = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistics(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapChangePercentage24H)
        
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime) minutes"
        let blockStat = Statistics(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetails?.hashingAlgorithm ?? "n/a"
        let hashStat = Statistics(title: "Hashing Algorithm", value: hashing)
        
        let additionalStatistics = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashStat]
        
        return additionalStatistics
    }
}
