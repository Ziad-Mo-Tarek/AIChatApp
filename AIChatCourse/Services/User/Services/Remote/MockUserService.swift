//
//  MockUserService.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 21/05/2026.
//


struct MockUserService: RemoteUserService {
    
    let currentUser: UserModel?
    
    init(currentUser: UserModel? = nil) {
        self.currentUser = currentUser
    }
    
    func saveUser(user: UserModel) async throws {
        
    }
    
    func markOnboardingCompleted(userId: String, selectedColorHex: String) async throws {
        
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let user = currentUser {
                continuation.yield(user)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
    
    
}