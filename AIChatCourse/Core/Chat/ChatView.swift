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
    @State var showChatSettings: Bool = false
    @State var scrollPosition: String?
    
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
        .confirmationDialog("", isPresented: $showChatSettings) {
            Button("Report user / chat", role: .destructive) {
                
            }
            
            Button("Delete chat", role: .destructive) {
                
            }
        } message: {
            Text("What would you like to do?")
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
                        imageName: isCurrentUser ? nil : avatar?.profileImageName
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
        
    }
    
    func onChatSettingsPressed() {
        showChatSettings = true
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
