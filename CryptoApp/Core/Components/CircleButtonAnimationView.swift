//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/22/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0) // ripple effect
            .animation(animate ? Animation.easeIn(duration: 1.0) : .none)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
            .foregroundStyle(.red)
            .frame(width: 100, height: 100)
    }
}
