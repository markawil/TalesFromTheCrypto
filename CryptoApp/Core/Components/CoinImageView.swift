//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(with coin: Coin) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(with: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondarText)
            }
        }
    }
}

struct CoinImageView_previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(with: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
