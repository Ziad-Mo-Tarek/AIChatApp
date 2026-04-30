//
//  ProfileView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @State var showSettingsView: Bool = false
    @State var showCreateAvatarView: Bool = false
    @State var myAvatars: [AvatarModel] = /*AvatarModel.mocks*/ []
    @State var currentUser : UserModel? = .mock
    @State var isLoading : Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                myInfoSection
                muAvatarsView
            } 
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showCreateAvatarView) {
            CreateAvatarView()
        }
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        try? await Task.sleep(for: .seconds(3))
        isLoading = false
        myAvatars = AvatarModel.mocks
    }
    
    var myInfoSection: some View {
        Section {
            ZStack {
                Circle()
                    .fill(Color(currentUser?.profileColorCalculated ?? .accent))
            }
            .frame(width: 100, height: 100)
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonPressed()
            }
    }
    
    func onSettingsButtonPressed() {
        showSettingsView = true
    }
    
    func onNewAvatarButtonPressed() {
        showCreateAvatarView = true
    }
    
    private func onDeleteAvatar(indesxSet: IndexSet) {
        guard let index = indesxSet.first else { return }
        myAvatars.remove(at: index)
    }
    
    private var muAvatarsView: some View {
        Section {
            if myAvatars.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Press + to add a new avatar")
                    }
                }
                
                .padding(50)
                .frame(maxWidth: .infinity)
                .font(.body)
                .foregroundStyle(.secondary)
                .removeListRowFormatting()
            } else {
                ForEach(myAvatars, id: \.self) { avatar in
                    CustomListCellView(
                        imageName: avatar.profileImageName,
                        title: avatar.name,
                        subtitle: nil
                    )
                    .anyButton(.highlight){
                        
                    }
                    .removeListRowFormatting()
                }
                .onDelete { indexSet in
                    onDeleteAvatar(indesxSet: indexSet)
                }
            }
        } header: {
           HStack {
                Text("My avatars")
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.accent)
                    .anyButton {
                        onNewAvatarButtonPressed()
                    }
            }
        }
    }
}

#Preview {
    ProfileView()
}
