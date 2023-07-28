//
//  Constant.swift
//  Devote
//
//  Created by Cristina on 2023-07-28.
//

import SwiftUI

// MARK: - FORMATTER
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

