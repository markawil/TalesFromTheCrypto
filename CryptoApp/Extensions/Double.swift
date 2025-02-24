//
//  Double.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Foundation

extension Double {
    
    /// computed private property to get currency in USD
    /// ```
    /// Convert 12.3456   to $12.34
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // these 3 are default already
        formatter.locale = .current
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        // need to implement
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converst a Double into currency in USD with 2 decimal places
    /// ```
    /// Convert 12.3456   to "$12.34"
    /// ```
    func currencyWith2Decimals() -> String {
        return currencyFormatter2.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    /// computed private property to get currency in USD
    /// ```
    /// Convert 1234.56   to $1,234.56
    /// Convert 12.3456   to $12.3456
    /// Convert 0.1234.56 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // these 3 are default already
        formatter.locale = .current
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        // need to implement
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converst a Double into currency in USD with 2-6 decimal places
    /// ```
    /// Convert 1234.56   to "$1,234.56"
    /// Convert 12.3456   to "$12.3456"
    /// Convert 0.1234.56 to "$0.123456"
    /// ```
    func currencyWith6Decimals() -> String {
        return currencyFormatter6.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    /// Converst a Double into currency in USD with 2-6 decimal places
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func numberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converst a Double into currency in USD with 2-6 decimal places
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func percentString() -> String {
        return numberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.numberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.numberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.numberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.numberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.numberString()

        default:
            return "\(sign)\(self)"
        }
    }
}
