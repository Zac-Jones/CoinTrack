//
//  SingleCoinView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct SingleCoinView: View {
    @Environment(\.presentationMode) var presentationMode
    let coin: Coin

    var body: some View {
        VStack {
            Text(coin.name)
                .font(.title)
            Text("Symbol: \(coin.symbol)")
            Text("Price: $\(String(format: "%.2f", coin.currentPrice))")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
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
}
