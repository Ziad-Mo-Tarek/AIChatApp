//
//  ChatRowCellViewBuilder.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 25/04/2026.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    var currentUserId: String? = ""
    var chat: ChatModel = .mock
    var getAvatar: () async -> AvatarModel?
    var getLastChatMessage: () async -> ChatMessageModel?
    
    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?
    
    @State var didLoadAvatar: Bool = false
    @State var didLoadChatMessage: Bool = false
    
    private var isLoading: Bool {
        !(didLoadAvatar && didLoadChatMessage)
    }
    
    var hasNewChat: Bool {
        guard let lastChatMessage, let currentUserId else {
            return false
        }
        return lastChatMessage.hasBeenSeenBy(userId: currentUserId)
        
    }
    
    var subHeadline: String? {
        if isLoading {
            return "xxxx xxxx xxxx xxxx"
        }
        
        if avatar == nil && lastChatMessage == nil {
            return "Error loading data."
        }
        
        return lastChatMessage?.content
    }
    
    var body: some View {
        ChatRowCellView(
            imageName: avatar?.profileImageName,
            headline: isLoading ? "xxxx xxxx" : avatar?.name,
            subHeadline: subHeadline,
            hasNewChat: isLoading ? false : hasNewChat
        )
        .redacted(reason: isLoading ? .privacy : [])
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastChatMessage = await getLastChatMessage()
            didLoadChatMessage = true
        }
    }
    
    
    
}

#Preview {
    VStack {
        ChatRowCellViewBuilder(chat: .mock, getAvatar: {
            try? await Task.sleep(for: .seconds(5))
            return .mock
        }, getLastChatMessage: {
            try? await Task.sleep(for: .seconds(5))
            return .mock
        })
        ChatRowCellViewBuilder(chat: .mock, getAvatar: {
            .mock
        }, getLastChatMessage: {
            .mock
        })
        ChatRowCellViewBuilder(chat: .mock, getAvatar: {
            nil
        }, getLastChatMessage: {
            nil
        })
    }
    
}
