//
//  DefaultView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct DefaultView: View {
    @Binding var coins: [Coin]
    @Binding var favouriteCoins: [Coin]
    @State private var currentPage = "Dashboard"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentPage) {
                HomeView(coins: coins)
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Dash")
                    }
                    .tag("Dashboard")
                
                FavouritesView(coins: $favouriteCoins)
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
