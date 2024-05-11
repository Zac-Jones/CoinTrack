//
//  ProfileView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
            }
            .navigationBarTitle("Profile")
            .navigationBarItems(leading: backButton)
        }
        .navigationBarBackButtonHidden(mode.wrappedValue.isPresented)
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
    ProfileView()
}
