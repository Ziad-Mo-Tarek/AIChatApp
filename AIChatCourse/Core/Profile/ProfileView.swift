//
//  ProfileView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @State var showSettingsView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettingsView) {
            Text("jfhejfejf")
        }
    }
    
    var settingsButton: some View {
        Button {
            onSettingsButtonPressed()
        } label: {
            Image(systemName: "gear")
                .font(.headline)
        }

    }
    
    func onSettingsButtonPressed() {
        showSettingsView = true
    }
    
}

#Preview {
    ProfileView()
}
