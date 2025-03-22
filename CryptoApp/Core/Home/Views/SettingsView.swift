//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/18/25.
//

import SwiftUI

struct SettingsView: View {
    
    private let githubURL = URL(string: "https://github.com/markawil")!
    private let linkedInURL = URL(string: "https://www.linkedin.com/in/mark-wilkinson-5ba5ba20")!
    
    @Environment(\.presentationMode) private var mode
    
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                aboutSection
                coinGeckoSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
        }
        
    }
}

extension SettingsView {
    
    private var aboutSection: some View {
        Section(header: Text("About")) {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.secondary)
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was based on Nick Serano's CoinGecko API app @SwiftfulThinking.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
                    .padding(.top, 5)
            }
            .padding(.vertical, 5)
            HStack {
                Image("github-icon")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Link("My Github page", destination: githubURL)
            }
            HStack {
                Image("linkedin-icon")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Link("My LinkedIn page", destination: linkedInURL)
            }
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API provided by CoinGecko. Prices may be slightly delayed. Note that your own API key from CoinGecko is required to access more data.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical, 5)
            Link("Visit Coingecko.com 🦎", destination: URL(string: "https://www.coingecko.com/")!)
        }
    }
}

#Preview {
    SettingsView()
}
