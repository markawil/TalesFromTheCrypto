//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/22/25.
//

import Foundation

// CoinGecko API Info
/*
 
 URL: https://api.coingecko.com/api/v3/coins/markets?order=market_cap_desc&per_page=250&page=1&sparkline=false
 Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 96331,
     "market_cap": 1910183395891,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1910183395891,
     "total_volume": 15336705859,
     "high_24h": 96881,
     "low_24h": 96136,
     "price_change_24h": -107.37760801670083,
     "price_change_percentage_24h": -0.11134,
     "market_cap_change_24h": -1467274633.5373535,
     "market_cap_change_percentage_24h": -0.07675,
     "circulating_supply": 19827893,
     "total_supply": 19827893,
     "max_supply": 21000000,
     "ath": 108786,
     "ath_change_percentage": -11.37872,
     "ath_date": "2025-01-20T09:11:54.494Z",
     "atl": 67.81,
     "atl_change_percentage": 142074.53438,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2025-02-23T05:19:57.641Z",
     "sparkline_in_7d": {
       "price": [
         97651.63779310409,
         97619.7866463706
       ]
     },
     "price_change_percentage_24h_in_currency": -0.11134369288792335
   }
 */

enum CoinSortOptions {
    case rank
    case rankReversed
    case holdings
    case holdingsReversed
    case price
    case priceReversed
}

struct Coin: Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id,
                    symbol: symbol,
                    name: name,
                    image: image,
                    currentPrice: currentPrice,
                    marketCap: marketCap,
                    marketCapRank: marketCapRank,
                    fullyDilutedValuation: fullyDilutedValuation,
                    totalVolume: totalVolume,
                    high24H: high24H,
                    low24H: low24H,
                    priceChange24H: priceChange24H,
                    priceChangePercentage24H: priceChangePercentage24H,
                    marketCapChange24H: marketCapChange24H,
                    marketCapChangePercentage24H: marketCapChangePercentage24H,
                    circulatingSupply: circulatingSupply,
                    totalSupply: totalSupply,
                    maxSupply: maxSupply,
                    ath: ath,
                    athChangePercentage: athChangePercentage,
                    athDate: athDate,
                    atl: atl,
                    atlChangePercentage: atlChangePercentage,
                    atlDate: atlDate,
                    lastUpdated: lastUpdated,
                    sparklineIn7D: sparklineIn7D,
                    priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
                    currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
