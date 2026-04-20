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

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation

    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }
    
    init(avatar: AvatarModel){
        self.characterOption = avatar.characterOption ?? .defaultValue
        self.characterAction = avatar.characterAction ?? .defaultValue
        self.characterLocation = avatar.characterLocation ?? .defaultValue
    }
    
    var characterDescription: String {
        let prefix = characterOption.startsWithAVowel ? "An" : "A"
        return "\(prefix) \(characterOption) that is \(characterAction) in the \(characterLocation)."
    }
    
}

enum CharacterOption: String, CaseIterable, Hashable {
    case man, woman, alien, cat, dog
    
    static var defaultValue: Self {
        .man
    }
    
    var startsWithAVowel: Bool {
        return ["e", "a", "i", "o", "u"].contains { vowel in
            self.rawValue.first == Character(vowel)
        }
    }
    
}

enum CharacterAction: String {
    case smiling, eating, sitting, drinking, walking, shopping, studying,
         laughing, dancing, crying, sleeping, fighting
    static var defaultValue: Self {
        .fighting
    }
}

enum CharacterLocation: String {
    case park, mall, museum, city, beach, forest, desert, mountain, space
    static var defaultValue: Self {
        .mountain
    }
}
