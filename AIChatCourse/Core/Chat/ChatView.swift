//
//  ChatView.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 03/05/2026.
//

import SwiftUI



struct ChatView: View {
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State var avatar: AvatarModel? = .mock
    @State var currentUser: UserModel? = .mock
    @State var textFieldText: String = ""
    @State var showChatSettings: AnyAppAlert? = nil
    @State var scrollPosition: String?
    @State var showAlert: AnyAppAlert?
//    @State var alertTitle: String? = nil
    @State var showProfileModal: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton {
                        onChatSettingsPressed()
                    }
            }
        }
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSettings)
        .showCustomAlert(alert: $showAlert)
        .showModal(showModal: $showProfileModal) {
            if let avatar {
                profileModal(avatar: avatar)
            }
        }
    }
    
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24){
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == currentUser?.id
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName,
                        onImagePressed: onAvatarImagePressed
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .scrollIndicators(.hidden)
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrollPosition)
    }
     
    private var textFieldSection: some View {
        TextField("Say something...", text: $textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 40)
            .overlay(alignment: .trailing, content: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 4)
                    .foregroundStyle(.accent)
                    .anyButton(.plain) {
                        onSendMessageSent()
                    }
            })
            .background (
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.gray.opacity(0.03), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground).ignoresSafeArea())
    }
    
    
    
    private func onSendMessageSent() {
        guard let currentUser else { return }
        let content = textFieldText
        
        do {
            try TextValidationHelper.checkIfTextIsValid(text: content)
            let message = ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: currentUser.id,
                content: content,
                seenByIds: nil,
                dateCreated: .now
            )
            chatMessages.append(message)
            scrollPosition = message.id
            textFieldText = ""
        } catch {
            showAlert = AnyAppAlert(error: error)
//            showAlert = true
        }
        
    }
    
    func onChatSettingsPressed() {
        showChatSettings = AnyAppAlert(
            title: "",
            subtitle: "What would you like to do?",
            buttons: {
                AnyView (
                    Group {
                        Button("Report", role: .destructive) {
                            
                        }
                        Button("Delete", role: .destructive) {
                            
                        }
                    }
                )
            }
        )
    }
    
    private func profileModal(avatar: AvatarModel) -> some View {
        ProfileModalView(
            imageName: avatar.profileImageName,
            title: avatar.name,
            subTitle: avatar.characterOption?.rawValue.capitalized,
            headline: avatar.characterDescription,
            onXmarkTapped: {
                showProfileModal = false
            }
        )
        .padding(40)
        .transition(.slide)
    }
    
    private func onAvatarImagePressed() {
        showProfileModal = true
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
