//
//  MockAuthService.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 17/05/2026.
//

import SwiftUI



struct MockAuthService: AuthService {
    
    let currentUser: UserAuthInfo?
    
    init(currentUser: UserAuthInfo? = nil) {
        self.currentUser = currentUser
    }
    
    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { cont in
            cont.yield(self.currentUser)
        }
    }
    
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        self.currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, true)
    }
    
    func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: false)
        return (user, false)
    }
    
    func signOut() throws {
        
    }
    
    func deleteUser() async throws {
        
    }
    
}
