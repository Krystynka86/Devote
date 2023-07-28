//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Cristina on 2023-07-28.
//

import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
