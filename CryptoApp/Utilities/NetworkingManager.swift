//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Combine
import Foundation

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "[🔥] Bad URL Response: \(url)"
            case .unknown:
                return "[⚠️] Unknown Error"
            }
        }
    }
    
    static func download(for request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                return try handle(urlResponse: output, url: request.url!)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handle(urlResponse output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    static func handle(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("Finished")
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    static func apiKey() -> String? {
        guard let bundlePath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: bundlePath) as? [String: AnyObject],
              let apiKey = dict["API_KEY"] as? String else {
            return nil
        }
        
        return apiKey
    }
}
