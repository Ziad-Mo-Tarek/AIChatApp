//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var path: [NaviagtionPathOptions] = []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: nil,
                        chat: chat) {
                            try? await Task.sleep(for: .seconds(1))
                            return AvatarModel.mocks.randomElement()!

                        } getLastChatMessage: {
                            try? await Task.sleep(for: .seconds(1))
                            return ChatMessageModel.mocks.randomElement()!
                        }
                        .anyButton(.highlight, action: {
                            onChatPressed(chat: chat)
                        })
                        .removeListRowFormatting()
                }
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModeule(path: $path)
            
//            Text("Chats")
//                .navigationTitle("Chats")
        }
    }
    
    func onChatPressed(chat: ChatModel) {
        path.append(.chatView(avatarId: chat.avatarId ))
    }
    
}

#Preview {
    NavigationStack {
        ChatsView()
    }
}
