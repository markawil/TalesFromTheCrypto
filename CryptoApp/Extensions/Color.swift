//
//  Color.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/22/25.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let redColor = Color("RedColor")
    let greenColor = Color("GreenColor")
    let secondarText = Color("SecondaryTextColor")
}
