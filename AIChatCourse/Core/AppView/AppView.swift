//
//  AppView.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 07/04/2026.
//

import SwiftUI

struct AppView: View {
    @Environment(AuthManager.self) private var authManager
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
        .onChange(of: appState.showTabBar) { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authManager.auth {
            print("User already authenticated: \(user.uid)")
        } else {
            
            do {
                let result = try await authManager.signInAnonymously()
                print("sign in anonymously success: \(result.user.uid)")
            } catch {
                print(error)
            }
            
        }
    }
}

#Preview {
    AppView(appState: AppState.init(showTabBar: true))
}

#Preview {
    AppView(appState: AppState.init(showTabBar: false))
}
