//
//  SettingsView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) var appState
    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignOutPressed()
                } label: {
                    Text("Sign out")
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func onSignOutPressed(){
        // some logic
        dismiss()
        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateShowTabBar(false)
        }
    }
    
}

#Preview {
    SettingsView()
        .environment(AppState())
}
