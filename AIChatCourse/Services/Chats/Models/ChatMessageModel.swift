//
//  ChatMessageModel.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 25/04/2026.
//

import Foundation


struct ChatMessageModel: Identifiable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: String?
    let seenByIds: [String]?
    let dateCreated: Date
    
    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
    
    func hasBeenSeenBy(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }
    
    static var mock: ChatMessageModel {
        mocks[0]
    }
    
    static var mocks: [ChatMessageModel] = [
        .init(
            id: "msg_1",
            chatId: "chat_1",
            authorId: "user_1",
            content: "Hey, how are you?",
            seenByIds: ["user_2"],
            dateCreated: Date()
        ),
        .init(
            id: "msg_2",
            chatId: "chat_1",
            authorId: "user_2",
            content: "I'm good! What about you?",
            seenByIds: ["user_1"],
            dateCreated: Date().adding(minutes: -5)
        ),
        .init(
            id: "msg_3",
            chatId: "chat_1",
            authorId: "user_1",
            content: "Doing great, working on the chat feature.",
            seenByIds: ["user_2"],
            dateCreated: Date().adding(hours: -1)
        ),
        .init(
            id: "msg_4",
            chatId: "chat_1",
            authorId: "user_2",
            content: "Nice 🔥 keep going!",
            seenByIds: nil,
            dateCreated: Date().adding(days: -1)
        )
    ]
    
}
