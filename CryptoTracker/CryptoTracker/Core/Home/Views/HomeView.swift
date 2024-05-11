//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 8/5/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var cryptoData: [Coin] = []
    let coins: [Coin]
    @State private var coins_: [Coin] = []
    @State private var favouriteCoins: [Coin] = []
    
    init(coins: [Coin]) {
        self.coins = coins
    }
    
    var filteredCoins: [Coin] {
        return coins.sorted(by: { $0.priceChangePercentage24h > $1.priceChangePercentage24h })
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Top 24h Coins:")
                .bold()
                .font(.title2)
                .padding(.leading, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(filteredCoins.prefix(20), id: \.id) { coin in
                        NavigationLink(destination: SingleCoinView(coin: coin, coins: $coins_)) {
                            CoinItemView(coin: coin)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Text("Top 5 Favourites:")
                .bold()
                .font(.title2)
                .padding(.leading, 16)
            List {
                ForEach(favouriteCoins.indices, id: \.self) { index in
                    if (index < 5) {
                        let coin = favouriteCoins[index]
                        NavigationLink(destination: SingleCoinView(coin: coin, coins: $coins_)) {
                            HStack {
                                AsyncImage(url: coin.image) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing, 8)
                                    default:
                                        Image(systemName: "questionmark.circle")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing, 8)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(coin.name)
                                            .font(.headline)
                                        
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        
                                        Spacer()
                                        Text("$\(String(format: "%.2f", coin.currentPrice))")
                                            .font(.headline)
                                    }
                                    Text(coin.symbol.uppercased())
                                        .font(.subheadline)
                                    Text("\(String(format: "%.2f", coin.priceChangePercentage24h))%")
                                        .font(.title2)
                                        .foregroundColor(coin.priceChangePercentage24h < 0 ? .red : .green)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
        }
        .onAppear {
            Task {
                do {
                    self.coins_ = try await CoinService.shared.fetchCoinDataAsync()
                    loadFavouriteCoins()
                } catch {
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    private func loadFavouriteCoins() {
        favouriteCoins = coins_.filter { UserDefaults.standard.bool(forKey: "fav_\($0.id)") }
        favouriteCoins = favouriteCoins.sorted(by: { $0.priceChangePercentage24h > $1.priceChangePercentage24h })
    }
}

struct CoinItemView: View {
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: coin.image) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 8)
                default:
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 8)
                }
            }
            
            Text(coin.name)
            
            HStack(spacing: 2){
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                Text(String(format: " $%.2f", coin.currentPrice))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text("\(String(format: "%.2f", coin.priceChangePercentage24h))%")
                .font(.title2)
                .foregroundColor(coin.priceChangePercentage24h < 0 ? .red : .green)
        }
        .frame(width: 140, height: 140)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 2)
        )
    }
}
