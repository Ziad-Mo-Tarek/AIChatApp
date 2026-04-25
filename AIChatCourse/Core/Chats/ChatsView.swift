//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.mocks
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(chats) { chat in
                    Text(chat.id)
                }
            }
            
            Text("Chats")
                .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
