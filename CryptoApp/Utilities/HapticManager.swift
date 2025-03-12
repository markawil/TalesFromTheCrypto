//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/5/25.
//

import SwiftUI
import Foundation

class HapticManager {
    
    private static let generator = UINotificationFeedbackGenerator()
    
    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        generator.notificationOccurred(type)
    }
}
