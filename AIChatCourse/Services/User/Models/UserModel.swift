//
//  UserModel.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 28/04/2026.
//

import Foundation
import SwiftUI

struct UserModel {
    let id: String
    let dateCreated: Date?
    let didCompleteOnBoarding: Bool
    let profileColorHex: String?
    
    init(
        id: String,
        dateCreated: Date? = nil,
        didCompleteOnBoarding: Bool,
        profileColorHex: String? = nil
    ) {
        self.id = id
        self.dateCreated = dateCreated
        self.didCompleteOnBoarding = didCompleteOnBoarding
        self.profileColorHex = profileColorHex
    }
    
    var profileColorCalculated: Color {
        guard let profileColorHex else {
            return .accent
        }
        
        return Color(hex: profileColorHex)
    }
    
    static var mock: UserModel {
        mocks[0]
    }
    
    static var mocks: [UserModel] = [
        UserModel(
            id: "user_1",
            dateCreated: Date(),
            didCompleteOnBoarding: true,
            profileColorHex: "#FF3B30"
        ),
        UserModel(
            id: "user_2",
            dateCreated: Date().adding(days: -1),
            didCompleteOnBoarding: false,
            profileColorHex: "#007AFF"
        ),
        UserModel(
            id: "user_3",
            dateCreated: Date().adding(days: -2),
            didCompleteOnBoarding: true,
            profileColorHex: "#34C759"
        ),
        UserModel(
            id: "user_4",
            dateCreated: Date().adding(days: -3),
            didCompleteOnBoarding: false,
            profileColorHex: nil
        )
    ]
    
}
