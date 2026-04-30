//
//  CompletedView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct CompletedView: View {
    @Environment(AppState.self) private var appState
    @State var selectedColor: Color = .orange
    @State var isCompletingProfileSetup: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Setup complete")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)
            
            Text("You can now start chatting with your AI assistant.")
                .font(.title)
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
            

        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            ctaButton
        }
        .toolbar(.hidden, for: .navigationBar)
        .padding(24)
    }
    
    func onComplete() {
        // some logic
        isCompletingProfileSetup = true
        Task {
            try? await Task.sleep(for: .seconds(3))
            isCompletingProfileSetup = false
            appState.updateShowTabBar(true)
        }
    }
    
    var ctaButton: some View {
        AsyncCallToActionButton(
            isLoading: isCompletingProfileSetup,
            content: "Finish",
            onComplete: onComplete
        )
    }
    
}

#Preview {
    NavigationStack {
        CompletedView()
    }
    .environment(AppState())
}
