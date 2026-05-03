//
//  Binding+EXT.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 03/05/2026.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value : Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
