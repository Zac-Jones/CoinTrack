//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Zac Jones on 8/5/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue
    
    private var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil}
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
    
    @State private var coins: [Coin] = []
    @State private var favouriteCoins: [Coin] = []

    var body: some Scene {
        WindowGroup {
            DefaultView(coins: $coins, favouriteCoins: $favouriteCoins)
                .onAppear {
                    loadInitialData()
                }
                .accentColor(.red)
                .preferredColorScheme(selectedScheme)
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
