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
    static let launch = LaunchTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let redColor = Color("RedColor")
    let greenColor = Color("GreenColor")
    let secondarText = Color("SecondaryTextColor")
    let hotPink = Color("HotPinkColor")
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
