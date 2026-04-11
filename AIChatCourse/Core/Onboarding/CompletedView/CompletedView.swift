//
//  CompletedView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct CompletedView: View {
    @Environment(AppState.self) private var appState
    var body: some View {
        VStack {
            Text("Onboarding Completed")
                .frame(maxHeight: .infinity)
            
            Button {
                onComplete()
            } label: {
                Text("Finish")
                    .callToActionButton()
            }

        }
        .padding(16)
    }
    
    func onComplete() {
        // some logic
        appState.updateShowTabBar(true)
    }
    
}

#Preview {
    CompletedView()
        .environment(AppState())
}
