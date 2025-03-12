//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/24/25.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: Statistics
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondarText)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (statistic.percentageChange ?? 0) < 0 ? 180 : 0))
                Text(statistic.percentageChange?.percentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((statistic.percentageChange ?? 0) < 0 ? Color.theme.redColor : Color.theme.greenColor)
            .opacity(statistic.percentageChange == nil ? 0 : 1)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            StatisticView(statistic: dev.stat1)
            StatisticView(statistic: dev.stat2)
            StatisticView(statistic: dev.stat3)
        }
    }
}
