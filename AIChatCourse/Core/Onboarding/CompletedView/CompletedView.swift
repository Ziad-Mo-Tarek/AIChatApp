//
//  CompletedView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct CompletedView: View {
    @Environment(AppState.self) private var appState
    @Environment(UserManager.self) private var userManager
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
            let hex = selectedColor.toHex() ?? Constants.accentColor
            try await userManager.markOnboardingCompletedForCurrentUser(selectedColorHex: hex)
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
    .environment(UserManager(service: MockUserService()))
    .environment(AppState())
}
