//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var path: [NaviagtionPathOptions] = []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    recentsSection
                }
                
                chatsSection
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModeule(path: $path)
            
//            Text("Chats")
//                .navigationTitle("Chats")
        }
    }
    
    private var chatsSection: some View {
        Section {
            if chats.isEmpty {
                 Text("Your chats will appear here!")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(40)
                    .removeListRowFormatting()

            } else {
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
        } header: {
            Text("Chats")
        }
    }
    
    private var recentsSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(recentAvatars, id: \.self) { avatar in
                        if let imageName = avatar.profileImageName {
                            VStack(alignment: .center, spacing: 8) {
                                ImageLoader(urlString: imageName)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(Circle())
                                    
                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .anyButton {
                                onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: 120)
            .removeListRowFormatting()
            .scrollIndicators(.hidden)
        } header: {
            Text("Recents")
        }

    }
    
    func onChatPressed(chat: ChatModel) {
        path.append(.chatView(avatarId: chat.avatarId ))
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chatView(avatarId: avatar.avatarId ))
    }
    
}

#Preview {
    NavigationStack {
        ChatsView()
    }
}
