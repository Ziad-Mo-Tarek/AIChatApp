//
//  UserModel.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 28/04/2026.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnBoarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnBoarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnBoarding = didCompleteOnBoarding
        self.profileColorHex = profileColorHex
    }
    
    init(auth: UserAuthInfo, creationVersion: String?){
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnBoarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
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
            userId: "user_1",
            creationDate: Date(),
            didCompleteOnBoarding: true,
            profileColorHex: "#FF3B30"
        ),
        UserModel(
            userId: "user_2",
            creationDate: Date().adding(days: -1),
            didCompleteOnBoarding: false,
            profileColorHex: "#007AFF"
        ),
        UserModel(
            userId: "user_3",
            creationDate: Date().adding(days: -2),
            didCompleteOnBoarding: true,
            profileColorHex: "#34C759"
        ),
        UserModel(
            userId: "user_4",
            creationDate: Date().adding(days: -3),
            didCompleteOnBoarding: false,
            profileColorHex: nil
        )
    ]
    
}
