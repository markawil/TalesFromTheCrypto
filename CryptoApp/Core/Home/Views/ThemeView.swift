//
//  ThemeView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/18/25.
//

import SwiftUI

struct ThemeView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)
                Text("Secondary Text Color")
                    .foregroundStyle(Color.theme.secondarText)
                Text("Red Color")
                    .foregroundStyle(Color.theme.redColor)
                Text("Green Color")
                    .foregroundStyle(Color.theme.greenColor)
            }
            .font(.headline)
        }
    }
}

#Preview {
    ThemeView()
}
