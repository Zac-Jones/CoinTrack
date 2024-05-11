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
                .bold()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton, trailing: favouriteButton)
            
            
             
            let priceHistory = mutableCoin.sparklineIn7d?.price.map { $0 * 1.51 } // multiply by 1.51 to convert to AUD from USD
            
            LineChartView(data: priceHistory ?? [],
                          title: "Price Trend (7 Days)",
                          legend: "Price in AUD",
                          style: Styles.lineChartStyleOne,
                          form: ChartForm.extraLarge, //size of form
                          rateValue: Int(mutableCoin.priceChangePercentage24h)//percentage value to state if its going up or down
                          
            )
            .padding(10)
            .onAppear {
                mutableCoin.isFavourited = UserDefaults.standard.bool(forKey: "fav_\(mutableCoin.id)")
                
            }
            
            HStack {
                Spacer()
                Text("\(mutableCoin.symbol.uppercased()):")
                Spacer()
                Text("$\(String(format: "%.2f", mutableCoin.currentPrice))")
                    .bold()
                Spacer()
                Text("\(String(format: "%.2f", mutableCoin.priceChangePercentage24h))%")
                    .foregroundColor(mutableCoin.priceChangePercentage24h < 0 ? .red : .green)
                Spacer()
            }
            
            HStack {
                VStack {
                    Text("High (24HR)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", mutableCoin.high24h))")
                        .foregroundColor(.green)
                }
                .frame(width: 180, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 2)
                )
                VStack {
                    Text("Low (24HR)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", mutableCoin.low24h))")
                        .foregroundColor(.red)
                }
                .frame(width: 180, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 2)
                )
            }
            .padding(10)
            
            HStack {
                VStack {
                    Text("Volume (24HR)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", mutableCoin.marketCapChange24h))")
                }
                .frame(width: 180, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 2)
                )
                VStack {
                    Text("Market Cap")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", mutableCoin.marketCap))")
                }
                .frame(width: 180, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 2)
                )
            }
            .padding(10)
            
            Spacer()
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
