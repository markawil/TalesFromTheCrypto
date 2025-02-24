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
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImages"
    private let imageName: String
    
    init (with coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let image = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.image = image
            print("Retrieved image from filemanager for \(coin.name)")
        } else {
            print("Downloading image for: \(coin.name)")
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        let request = URLRequest(url: url)
        
        imageSubscription = NetworkingManager.download(for: request)
            .tryMap { (data) -> UIImage? in
                UIImage(data: data)
            }
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] (image) in
                guard let self = self, let image = image else { return }
                self.image = image
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: image,
                                           imageName: self.imageName,
                                           folderName: folderName)
            })
    }
}
