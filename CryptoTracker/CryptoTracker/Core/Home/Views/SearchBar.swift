//
//  SearchBar.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical)
           
        }
       
    
}
