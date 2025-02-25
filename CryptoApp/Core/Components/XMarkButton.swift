//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/24/25.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
