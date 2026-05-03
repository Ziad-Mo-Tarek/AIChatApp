//
//  TextValidationHelper.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 03/05/2026.
//

import Foundation


struct TextValidationHelper {
    enum TextValidationError: LocalizedError {
        case notEnoughCharacters(min: Int)
        case hasBadWords
        
        var errorDescription: String? {
            switch self {
            case .notEnoughCharacters(let minimum):
                return "Please add atleast \(minimum) characters."
            case .hasBadWords:
                return "Bad words detected, please rephrase your message"
            }
        }
    }
    
   static func checkIfTextIsValid(text: String) throws {
        let minimumCharacterCount = 4
        
        guard text.count >= minimumCharacterCount else {
            throw TextValidationError.notEnoughCharacters(min: minimumCharacterCount)
        }
        
        let badWords: [String] = [
            "shit", "ass", "bitch"
        ]
        if badWords.contains(text.lowercased()) {
            throw TextValidationError.hasBadWords
        }
        // success
    }
}
