//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/23/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
