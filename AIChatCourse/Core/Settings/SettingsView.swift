//
//  SettingsView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI
import SwiftfulUtilities

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) var appState
    @State var isPremium: Bool = true
    @State var isAnonymous: Bool = true
    @State var ShowCreateAccountSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                
                accountSection
                puchaseSection
                applicationSection
                
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $ShowCreateAccountSheet) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
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
    
    private var accountSection: some View {
        Section {
            if isAnonymous {
                Text("Save and backuo data")
                    .rowFormatting()
                    .anyButton(.highlight){
                        onCreateAccountPressed()
                    }
                    .removeListRowFormatting()
            } else {
                Text("Sign out")
                    .rowFormatting()
                    .anyButton(.highlight){
                        
                    }
                    .removeListRowFormatting()
            }
            
            
            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight){
                    
                }
                .removeListRowFormatting()
            
        } header: {
            Text("Account")
        }
    }
    
    private var puchaseSection: some View {
        Section {
            HStack(spacing: 8, content: {
                Text("Account status: \(isPremium ? "Premium" : "Free")")
                Spacer()
                if isPremium {
                    Text("Manage")
                        .badgeButton()
                }
            })
            .rowFormatting()
            .anyButton(.highlight){
                
            }
            .disabled(!isPremium)
            .removeListRowFormatting()
            
            
        } header: {
            Text("Purchases")
        }
    }
    
    private var applicationSection: some View {
        Section {
            HStack(spacing: 8, content: {
                Text("Version: ")
                Spacer()
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
                
            })
            .rowFormatting()
            .removeListRowFormatting()
            
            HStack(spacing: 8, content: {
                Text("Build number: ")
                Spacer()
                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
                
            })
            .rowFormatting()
            .removeListRowFormatting()
            
            HStack(spacing: 8, content: {
                Text("Contact us: ")
                    .foregroundStyle(.blue)
                Spacer()
            })
            .rowFormatting()
            .anyButton(.highlight){
                
            }
            .removeListRowFormatting()
            
        } header: {
            Text("Application")
        } footer: {
            Text("Created by Ziad Tarek.\n contact me: z.ziad.tarek.t@gmail.com")
                .baselineOffset(6)
        }
    }
    
    func onCreateAccountPressed() {
        ShowCreateAccountSheet = true
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}

fileprivate extension View {
    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .systemBackground))
    }
}
