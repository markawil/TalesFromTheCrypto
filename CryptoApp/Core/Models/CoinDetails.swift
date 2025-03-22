//
//  CoinDetails.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/6/25.
//

import Foundation

class CoinDetails: Identifiable, Codable {
    let id, symbol, name: String?
    let description: Description?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var readableDescription: String {
        guard let description = description?.en else {
            return "No description available"
        }
        return description.removingHTMLOccurrences
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String?
    
    enum CodingKeys: String, CodingKey {
        case en
    }
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
