//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import SwiftUI
enum Theme {
    static let primary = Color("Primary")
}


enum SchemeType: Int, Identifiable, CaseIterable {
    var id: Self {self}
    case system
    case light
    case dark
}


extension SchemeType {
    var title: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .system:
            return "System"
        }
    }
}


struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue
    @Environment(\.colorScheme) private var colorScheme
   
    
    private var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil}
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
    var body: some View {
        Text("")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Settings")
            .navigationBarItems(leading: backButton)
        NavigationView {
            List {
                Section(header: Text("Theme")) {
                    ForEach(SchemeType.allCases, id: \.self) { scheme in
                        Button(action: {
                            systemTheme = scheme.rawValue
                        }) {
                            HStack {
                                Text(scheme.title)
                                Spacer()
                                if systemTheme == scheme.rawValue {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        .foregroundColor(scheme.rawValue == systemTheme ? .red : .gray)
                    }
                }
            }
            
        }.preferredColorScheme(selectedScheme)
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
