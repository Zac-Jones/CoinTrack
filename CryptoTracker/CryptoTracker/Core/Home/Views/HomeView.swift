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
    
    init(coins: [Coin]) {
        self.coins = coins
    }
    
    var filteredCoins: [Coin] {
        return coins.sorted(by: { $0.marketCap > $1.marketCap })
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
         
                Text("Top 24h Coins:")
                    .bold()
                    .font(.title2)
                    .padding(.leading, 16)
                
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        //loops through the top 10 coins
                        ForEach(filteredCoins.prefix(10), id: \.id) { coin in
                           
                            VStack(alignment: .leading) {
                                //image
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
                                
                                //information about the coin
                                HStack(spacing: 2){
                                    Text(coin.name)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                    Text(String(format: "%.3f", coin.currentPrice))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Text("\(coin.priceChangePercentage24h)") //not sure what the  percentage we need is
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                            .frame(width: 140, height: 140)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 2)
                            )
                            
                        }
                    
                }
            }.padding()
            
        Spacer()
        }
    
    }
}
