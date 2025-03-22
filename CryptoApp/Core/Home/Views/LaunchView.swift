//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/21/25.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading Crypto Values...".map { String($0)  }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loopCount: Int = 0
    @Binding var showLaunchView: Bool
    
    private let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            Image("CryptoTales_Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.theme.hotPink)
                                .offset(y: counter == index ? -7 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText = true
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    loopCount += 1
                    counter = 0
                    if loopCount == 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
