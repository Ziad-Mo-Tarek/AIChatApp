//
//  AvatarAttributes.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 30/04/2026.
//

import Foundation

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

enum CharacterAction: String, CaseIterable, Hashable {
    case smiling, eating, sitting, drinking, walking, shopping, studying,
         laughing, dancing, crying, sleeping, fighting
    static var defaultValue: Self {
        .fighting
    }
}

enum CharacterLocation: String, CaseIterable, Hashable {
    case park, mall, museum, city, beach, forest, desert, mountain, space
    static var defaultValue: Self {
        .mountain
    }
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
