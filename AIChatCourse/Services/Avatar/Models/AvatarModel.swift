//
//  AvatarModel.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 13/04/2026.
//

import Foundation


struct AvatarModel: Hashable {
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String?
    let dateCreated: Date?
    
    init(
        avatarId: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        authorId: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.authorId = authorId
        self.dateCreated = dateCreated
    }
    
    var characterDescription: String {
        AvatarDescriptionBuilder.init(avatar: self).characterDescription
    }
    
    static var mock: AvatarModel {
        mocks[0]
    }
    
    static var mocks: [AvatarModel] = [
        AvatarModel(
            avatarId: UUID().uuidString,
            name: "Alpha",
            characterOption: .man,
            characterAction: .smiling,
            characterLocation: .city,
            profileImageName: Constants.randomeImage,
            authorId: UUID().uuidString,
            dateCreated: Date()
        ),
        AvatarModel(
            avatarId: UUID().uuidString,
            name: "Beta",
            characterOption: .woman,
            characterAction: .shopping,
            characterLocation: .mall,
            profileImageName: Constants.randomeImage,
            authorId: UUID().uuidString,
            dateCreated: Date()
        ),
        AvatarModel(
            avatarId: UUID().uuidString,
            name: "Gamma",
            characterOption: .alien,
            characterAction: .laughing,
            characterLocation: .space,
            profileImageName: Constants.randomeImage,
            authorId: UUID().uuidString,
            dateCreated: Date()
        ),
        AvatarModel(
            avatarId: UUID().uuidString,
            name: "Delta",
            characterOption: .cat,
            characterAction: .sleeping,
            characterLocation: .forest,
            profileImageName: Constants.randomeImage,
            authorId: UUID().uuidString,
            dateCreated: Date()
        )
    ]
    
}

