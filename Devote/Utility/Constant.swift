//
//  Constant.swift
//  Devote
//
//  Created by Cristina on 2023-07-28.
//

import SwiftUI

// MARK: - FORMATTER
    let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(
        colors: [Color.pink, Color.blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - UX

let feedback = UINotificationFeedbackGenerator()

