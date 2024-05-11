//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let index: Int
    @State private var isFavourited = false

    var body: some View {
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
                    Text("\(index).")
                        .font(.headline)
                    Text(coin.name)
                        .font(.headline)
                    if isFavourited {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    Text("$\(String(format: "%.2f", coin.currentPrice))")
                        .font(.headline)
                }
                Text(coin.symbol.uppercased())
                    .font(.subheadline)
            }
        }
        .onAppear {
            isFavourited = UserDefaults.standard.bool(forKey: "fav_\(coin.id)")
        }
    }
    
}
