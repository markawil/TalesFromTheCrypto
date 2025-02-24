//
//  MarketData.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/24/25.
//

import Foundation

/// JSON Data and URL
/*
 URL: https://api.coingecko.com/api/v3/global
 
 Response: {
 "data": {
   "active_cryptocurrencies": 17166,
   "upcoming_icos": 0,
   "ongoing_icos": 49,
   "ended_icos": 3376,
   "markets": 1258,
   "total_market_cap": {
     "btc": 33971748.494623646,
     "eth": 1209010044.4493659,
     "ltc": 26458441728.78539,
     "bch": 10473998861.892082,
     "bnb": 5061226110.944176,
     "eos": 5409342237251.564,
     "xrp": 1337496891135.4277,
     "xlm": 10250196039605.723,
     "link": 199210376921.35706,
     "dot": 691888981851.7328,
     "yfi": 556545832.937058,
     "usd": 3193556808743.0024,
     "aed": 11729934158513.049,
     "ars": 3385601666792444,
     "aud": 5030177716564.722,
     "bdt": 387911959694551.56,
     "bhd": 1203447173579.478,
     "bmd": 3193556808743.0024,
     "brl": 18457161576130.18,
     "cad": 4553932170347.302,
     "chf": 2865444395099.129,
     "clp": 3014174722795908,
     "cny": 23147219105450.156,
     "czk": 76215191307694.38,
     "dkk": 22759473405516.625,
     "eur": 3051188046209.2397,
     "gbp": 2529488605932.9824,
     "gel": 8989862416611.55,
     "hkd": 24830702577179.03,
     "huf": 1224254792966843.2,
     "idr": 52022880736583064,
     "ils": 11425588194639.838,
     "inr": 276715629719644.53,
     "jpy": 478191220703144.2,
     "krw": 4565623743501429,
     "kwd": 985122855906.5715,
     "lkr": 943893165664690.4,
     "mmk": 6700082184742817,
     "mxn": 65402366825732.08,
     "myr": 14091569418578.498,
     "ngn": 4796307164346852,
     "nok": 35541713274521.766,
     "nzd": 5570463657467.862,
     "php": 184817529216245.47,
     "pkr": 892918483724543.6,
     "pln": 12645865412601.393,
     "rub": 280236114132455.44,
     "sar": 11976029646194.781,
     "sek": 34046154653203.35,
     "sgd": 4276571761507.97,
     "thb": 107004665308273.11,
     "try": 116349261628086.25,
     "twd": 104522834150597.05,
     "uah": 133344166993299.6,
     "vef": 319770843259.4368,
     "vnd": 81343780150744270,
     "zar": 58688967509096.83,
     "xdr": 2431947800323.545,
     "xag": 98724561311.73428,
     "xau": 1082008982.3702166,
     "bits": 33971748494623.645,
     "sats": 3397174849462364.5
   },
   "total_volume": {
     "btc": 1422076.3366286894,
     "eth": 50609834.675714135,
     "ltc": 1107565125.549232,
     "bch": 438447433.2762061,
     "bnb": 211865747.44129017,
     "eos": 226438082618.53094,
     "xrp": 55988365729.81057,
     "xlm": 429078922329.69073,
     "link": 8339057469.343316,
     "dot": 28962858618.277493,
     "yfi": 23297318.929414205,
     "usd": 133684068928.96873,
     "aed": 491021585176.1022,
     "ars": 141723173782419.16,
     "aud": 210566044338.15652,
     "bdt": 16238210955323.248,
     "bhd": 50376969798.916855,
     "bmd": 133684068928.96873,
     "brl": 772627076374.9747,
     "cad": 190630140190.9861,
     "chf": 119949100319.06863,
     "clp": 126175034777228.56,
     "cny": 968955500004.0582,
     "czk": 3190410410210.517,
     "dkk": 952724248775.0475,
     "eur": 127724433136.11531,
     "gbp": 105885803635.87897,
     "gel": 376320654035.04694,
     "hkd": 1039427056939.9641,
     "huf": 51247988350023.56,
     "idr": 2177706798649454,
     "ils": 478281493407.1713,
     "inr": 11583470572964.174,
     "jpy": 20017351166165.285,
     "krw": 191119555963126.3,
     "kwd": 41237792110.656845,
     "lkr": 39511894285033.03,
     "mmk": 280469176612976.3,
     "mxn": 2737779547529.091,
     "myr": 589880954149.0745,
     "ngn": 200776092602350.22,
     "nok": 1487795937819.865,
     "nzd": 233182715119.55942,
     "php": 7736564838109.485,
     "pkr": 37378065672539.664,
     "pln": 529362978249.3439,
     "rub": 11730840013713.473,
     "sar": 501323279527.7684,
     "sek": 1425191019920.0833,
     "sgd": 179019678804.50513,
     "thb": 4479274961895.183,
     "try": 4870444974938.722,
     "twd": 4375384125619.9316,
     "uah": 5581861190884.707,
     "vef": 13385785821.85764,
     "vnd": 3405095999183171.5,
     "zar": 2456752908348.6816,
     "xdr": 101802691118.58148,
     "xag": 4132665191.1273923,
     "xau": 45293499.39382389,
     "bits": 1422076336628.6895,
     "sats": 142207633662868.94
   },
   "market_cap_percentage": {
     "btc": 58.36784645670523,
     "eth": 9.972864247490277,
     "usdt": 4.457935510882102,
     "xrp": 4.3369187363769015,
     "bnb": 2.8828165896783915,
     "sol": 2.345346640594912,
     "usdc": 1.7713458298958613,
     "doge": 1.0273827106368816,
     "ada": 0.807119113768771,
     "steth": 0.778717216413109
   },
   "market_cap_change_percentage_24h_usd": -4.620540223045052,
   "updated_at": 1740433882
 }
}
 
 */

struct GlobalData: Codable {
    let data: MarketData
}

struct MarketData: Codable {
    
    let activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
    let markets: Int?
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    var marketCap: String {
        if let value = totalMarketCap["usd"] {
            return "$\(value.formattedWithAbbreviations())"
        }
        
        return ""
    }
    
    var volume: String {
        if let value = totalVolume["usd"] {
            return "$\(value.formattedWithAbbreviations())"
        }
        
        return ""
    }
    
    var btcDominance: String {
        if let btc = marketCapPercentage["btc"] {
            return btc.percentString()
        }
        
        return ""
    }
}
