//
//  ChatBubbleViewBuilder.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 03/05/2026.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    var message: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?
    
    var body: some View {
        ChatBubbleView(
            text: message.content ?? "",
            textColor: isCurrentUser ? .white : .primary,
            backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray6),
            imageName: imageName,
            showImage: !isCurrentUser
        )
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? 75 : 0)
        .padding(.trailing, isCurrentUser ? 0 : 75)
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 10) {
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorId: UUID().uuidString,
                    content: "this is some longer text that will wrap into multiple lines",
                    dateCreated: .now
                ),
                isCurrentUser: true
            )
            ChatBubbleViewBuilder()
            
        }
        .padding()
    }
}
