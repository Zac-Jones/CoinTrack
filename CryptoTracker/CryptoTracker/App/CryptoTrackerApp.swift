//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Zac Jones on 8/5/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @State private var coins: [Coin] = []
    @State private var favouriteCoins: [Coin] = []

    var body: some Scene {
        WindowGroup {
            DefaultView(coins: $coins, favouriteCoins: $favouriteCoins)
                .onAppear {
                    loadInitialData()
                }
                .accentColor(.red)
        }
    }

    private func loadInitialData() {
        Task {
            do {
                self.coins = try await CoinService.shared.fetchCoinDataAsync()
                loadFavouriteCoins()
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }

    private func loadFavouriteCoins() {
        favouriteCoins = coins.filter { UserDefaults.standard.bool(forKey: "fav_\($0.id)") }
    }
}
