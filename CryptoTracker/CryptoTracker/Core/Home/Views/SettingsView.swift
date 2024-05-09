//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Settings Screen")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Settings")
            .navigationBarItems(leading: backButton)
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

#Preview {
    SettingsView()
}
