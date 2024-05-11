//
//  SingleCoinView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI
import SwiftUICharts

struct SingleCoinView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var favouriteCoins: [Coin] = []
    @State private var mutableCoin: Coin
    @Binding var coins: [Coin]
    
    init(coin: Coin, coins: Binding<[Coin]>) {
        _coins = coins
        _mutableCoin = State(initialValue: coin)
    }
    

    
    var body: some View {
        VStack {
            Text(mutableCoin.name)
                .font(.title)
            Text("Symbol: \(mutableCoin.symbol)")
            Text("Price: $\(String(format: "%.2f", mutableCoin.currentPrice))")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton, trailing: favouriteButton)
            
            
            let priceHistory = mutableCoin.sparklineIn7d?.price
                        LineChartView(data: priceHistory ?? [],
                                      title: "Price Trend",
                                      legend: "Price in USD",
                                      style: Styles.lineChartStyleOne)
                        
                    }
        .onAppear {
            mutableCoin.isFavourited = UserDefaults.standard.bool(forKey: "fav_\(mutableCoin.id)")
           
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }
    }
    
    private var favouriteButton: some View {
        Button(action: {
            mutableCoin.isFavourited.toggle()
            UserDefaults.standard.set(mutableCoin.isFavourited, forKey: "fav_\(mutableCoin.id)")
            updateFavouriteCoins()
        }) {
            Image(systemName: mutableCoin.isFavourited ? "star.fill" : "star")
        }
    }
    
    private func updateFavouriteCoins() {
        favouriteCoins = coins.filter { UserDefaults.standard.bool(forKey: "fav_\($0.id)") }
    }
}
