//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let service: CoinImageService
    private var cancellable: AnyCancellable?
    
    init(with coin: Coin) {
        self.coin = coin
        self.service = CoinImageService(with: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        cancellable = service.$image
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] image in
                self?.image = image
            })
    }
}
