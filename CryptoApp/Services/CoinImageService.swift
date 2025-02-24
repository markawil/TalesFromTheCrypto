//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    init (with coin: Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        let request = URLRequest(url: url)
        
        imageSubscription = NetworkingManager.download(for: request)
            .tryMap { (data) -> UIImage? in
                UIImage(data: data)
            }
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] (image) in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
    }
}
