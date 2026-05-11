//
//  AppView.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 07/04/2026.
//

import SwiftUI

struct AppView: View {
    @Environment(\.authService) var authService
    @State var appState: AppState = .init()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabBar: {
                TabBarView()
            },
            onboarding: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            
        } else {
            
        }
    }
}

#Preview {
    AppView(appState: AppState.init(showTabBar: true))
}

#Preview {
    AppView(appState: AppState.init(showTabBar: false))
}
