//
//  String.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/18/25.
//

import Foundation

extension String {
    
    var removingHTMLOccurrences: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
