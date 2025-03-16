//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/6/25.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                CoinDetailView(coin: coin)
            }
        }
    }
}

struct CoinDetailView: View {
    
    @StateObject var detailsVM: CoinDetailViewModel
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    init(coin: Coin) {
        self._detailsVM = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ChartView(coin: detailsVM.coin)
                overviewTitle
                    .padding(.leading)
                Divider()
                overviewGrid
                    .padding(.leading)
                additionalTitle
                    .padding(.leading)
                Divider()
                additionalGrid
                    .padding(.leading)
            }
            .padding()
            
        }
        .navigationTitle(detailsVM.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarItems
            }
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CoinDetailView(coin: dev.coin)
        }
    }
}

extension CoinDetailView {
    
    private var navigationBarItems: some View {
        HStack {
            Text(detailsVM.coin.symbol.uppercased())
                .font(.caption)
                .foregroundStyle(Color.theme.secondarText)
            CoinImageView(with: detailsVM.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: 30) {
            ForEach(detailsVM.overviewStatistics) { stat in
                StatisticView(statistic: stat)
            }
        }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: 30) {
            ForEach(detailsVM.additionalStatistics) { stat in
                StatisticView(statistic: stat)
            }
        }
    }
}
