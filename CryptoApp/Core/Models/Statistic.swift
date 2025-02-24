//
//  Statistic.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/24/25.
//

import Foundation

struct Statistic: Identifiable {
    
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
