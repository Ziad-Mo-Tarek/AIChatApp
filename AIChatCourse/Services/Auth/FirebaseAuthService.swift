//
//  FirebaseAuthService.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 11/05/2026.
//

import Foundation
import FirebaseAuth
import SwiftUI

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = .init()
}

struct FirebaseAuthService {
    
    func getAuthenticatedUser() -> User? {
        if let user = Auth.auth().currentUser {
            return user
        }
        return nil
    }
    
    func  signInAnonymously() async throws -> AuthDataResult {
        try await Auth.auth().signInAnonymously()
    }
}
