//
//  GithubUserService.swift
//  BreathSmartCBL
//
//  Created by Mark Wilkinson on 3/9/25.
//

import Combine
import Foundation

class GithubUserService {
    
    @Published var githubUser: GithubUser?
        
    private var userSubscription: AnyCancellable?
    
    init() {
        try? loadUser(from: "markawil")
    }
    
    private func loadUser(from username: String) throws {
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
                
        userSubscription = NetworkingManager.download(for: request)
            .decode(type: GithubUser.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completion) in
                NetworkingManager.handle(completion: completion)
            }, receiveValue: { [weak self] user in
                self?.githubUser = user
                self?.userSubscription?.cancel()
            })
    }

}
