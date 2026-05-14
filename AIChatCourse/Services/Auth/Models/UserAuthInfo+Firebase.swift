//
//  UserAuthInfo+Firebase.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 14/05/2026.
//

import Foundation
import FirebaseAuth


extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
