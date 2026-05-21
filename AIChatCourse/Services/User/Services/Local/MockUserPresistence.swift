//
//  MockUserPresistence.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 21/05/2026.
//


struct MockUserPresistence: LocalUserPresistence {
    var currentUser: UserModel?
    
    init(currentUser: UserModel? = nil) {
        self.currentUser = currentUser
    }
    
    func getCurrentUser(key: String) throws -> UserModel? {
        currentUser
    }
    
    func saveUeer(user: UserModel?) throws {
        
    }
}