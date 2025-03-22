//
//  SettingsViewModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/20/25.
//

import Combine
import Foundation

class SettingsViewModel: ObservableObject {
    
    @Published var user: GithubUser?
    
    let service: GithubUserService
    private var cancellable: AnyCancellable?
    
    init(with service: GithubUserService = GithubUserService()) {
        self.service = service
        setupCombine()
    }
    
    private func setupCombine() {
        
        cancellable = service
            .$githubUser
            .receive(on: DispatchQueue.main)
            .assign(to: \.user, on: self)
    }
}
