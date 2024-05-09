//
//  DefaultView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct DefaultView: View {
    @State private var currentPage = "Dashboard"
    @State private var coins: [Coin] = []

    var body: some View {
        NavigationView {
            TabView(selection: $currentPage) {
                HomeView()
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Dash")
                    }
                    .tag("Dashboard")
                
                FavouritesView()
                    .tabItem {
                        Image(systemName: "star")
                        Text("Favourites")
                    }
                    .tag("Favourites")
                
                CoinsView(coins: coins)
                    .tabItem {
                        Image(systemName: "bitcoinsign.circle")
                        Text("Coins")
                    }
                    .tag("Coins")
                    .onAppear {
                        Task {
                            do {
                                self.coins = try await CoinService.shared.fetchCoinDataAsync()
                            } catch {
                                print("Error fetching data: \(error)")
                            }
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Text(currentPage)
                    .fontWeight(.bold)
                    .font(.title),
                trailing: HStack {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person")
                    }
                }
            )
        }
    }
}

#Preview {
    DefaultView()
}
