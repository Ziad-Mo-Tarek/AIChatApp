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
    
    var body: some View {
        VStack(spacing: 0){
            ScrollView {
                LazyVStack(spacing: 24){
                    ForEach(chatMessages) { message in
                        let isCurrentUser = message.authorId == currentUser?.id
                        ChatBubbleViewBuilder(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            imageName: isCurrentUser ? nil : avatar?.profileImageName
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(8)
            }
            .scrollIndicators(.hidden)
            
            Rectangle()
                .frame(height: 50)
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
