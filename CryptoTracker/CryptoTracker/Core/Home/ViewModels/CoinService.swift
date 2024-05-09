//
//  CoinService.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import Foundation

struct CoinService {
    static let shared = CoinService()
    
    func fetchCoinData(completion: @escaping (Result<[Coin], Error>) -> Void) {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=aud&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-piZ8nZk2wUp5knp9VDYiDUGL"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let fetchedCoins = try decoder.decode([Coin].self, from: data)
                completion(.success(fetchedCoins))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCoinDataAsync() async throws -> [Coin] {
        return try await withCheckedThrowingContinuation { continuation in
            self.fetchCoinData { result in
                switch result {
                case .success(let coins):
                    continuation.resume(returning: coins)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
