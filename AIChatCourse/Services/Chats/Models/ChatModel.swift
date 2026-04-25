//
//  ChatModel.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 25/04/2026.
//

import Foundation


struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date
    
    init(id: String, userId: String, avatarId: String, dateCreated: Date, dateModified: Date) {
        self.id = id
        self.userId = userId
        self.avatarId = avatarId
        self.dateCreated = dateCreated
        self.dateModified = dateModified
    }
    
    static var mock: ChatModel {
        mocks[0]
    }
    
    static var mocks: [ChatModel] = [
        .init(
            id: "chat_1",
            userId: "user_1",
            avatarId: "avatar_1",
            dateCreated: Date(),
            dateModified: Date()
        ),
        .init(
            id: "chat_2",
            userId: "user_2",
            avatarId: "avatar_2",
            dateCreated: Date().adding(days: -1),
            dateModified: Date().adding(hours: -1)
        ),
        .init(
            id: "chat_3",
            userId: "user_3",
            avatarId: "avatar_3",
            dateCreated: Date().adding(days: -2),
            dateModified: Date().adding(hours: -2)
        ),
        .init(
            id: "chat_4",
            userId: "user_4",
            avatarId: "avatar_4",
            dateCreated: Date().adding(days: -3),
            dateModified: Date().adding(hours: -3)
        )
    ]
    
}

