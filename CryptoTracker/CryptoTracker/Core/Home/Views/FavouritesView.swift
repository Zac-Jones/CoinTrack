//
//  FavouritesView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct FavouritesView: View {
    @State private var favouriteCoins: [Coin] = []
    @Binding var coins: [Coin]
    
    init(coins: Binding<[Coin]>) {
        _coins = coins
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favouriteCoins.indices, id: \.self) { index in
                    let coin = favouriteCoins[index]
                    NavigationLink(destination: SingleCoinView(coin: coin, coins: $coins)) {
                        CoinRowView(coin: coin, index: index + 1)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
            .onAppear {
                loadFavouriteCoins()
            }
        }
    }
    
    private func loadFavouriteCoins() {
        favouriteCoins = coins.filter { UserDefaults.standard.bool(forKey: "fav_\($0.id)") }
    }
}
