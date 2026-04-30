//
//  AsyncCallToActionButton.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 30/04/2026.
//

import SwiftUI

struct AsyncCallToActionButton: View {
    var isLoading: Bool = false
    var content: String = "Save"
    var onComplete: () -> Void
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else {
                Text(content)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            onComplete()
        }
        .disabled(isLoading)
    }
}

#Preview {
    AsyncCallToActionButton(){}
}
