//
//  CoinsView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct CoinsView: View {
    @State private var favouriteCoins: [Coin] = []
    @State private var cryptoData: [Coin] = []
    @State private var coins: [Coin] = []
    @State private var searchText = ""
    @State private var sortOption: SortOption = .marketCap
    
    init(coins: [Coin]) {
        self.coins = coins
    }
    
    var filteredCoins: [Coin] {
        if searchText.isEmpty {
            return cryptoData
        } else {
            let lowercasedSearchText = searchText.lowercased()
            return cryptoData.filter {
                $0.name.lowercased().contains(lowercasedSearchText) ||
                $0.symbol.lowercased().contains(lowercasedSearchText)
            }
        }
    }
    
    var sortedCoins: [Coin] {
        switch sortOption {
        case .name:
            return filteredCoins.sorted(by: { $0.name < $1.name })
        case .marketCap:
            return filteredCoins.sorted(by: { $0.marketCap > $1.marketCap })
        case .recentValue:
            return filteredCoins.sorted(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                
                Picker("Sort By", selection: $sortOption) {
                    Text("Alphabetical").tag(SortOption.name)
                    Text("Market Cap").tag(SortOption.marketCap)
                    Text("Recent Value").tag(SortOption.recentValue)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List {
                    ForEach(sortedCoins.indices, id: \.self) { index in
                        let coin = sortedCoins[index]
                        NavigationLink(destination: SingleCoinView(coin: coin, coins: $coins)) {
                            CoinRowView(coin: coin, index: index + 1)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.white)
                .refreshable {
                    await refreshCoins()
                }
            }
            .onAppear {
                loadFavouriteCoins()
                Task {
                    do {
                        self.cryptoData = try await CoinService.shared.fetchCoinDataAsync()
                    } catch {
                        print("Error fetching data: \(error)")
                    }
                }
            }
        }
    }
    
    @MainActor
    private func refreshCoins() async {
        do {
            self.cryptoData = try await CoinService.shared.fetchCoinDataAsync()
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    private func loadFavouriteCoins() {
        favouriteCoins = coins.filter { UserDefaults.standard.bool(forKey: "fav_\($0.id)") }
    }
    
    
    
    enum SortOption {
        case name
        case marketCap
        case recentValue
    }
}
