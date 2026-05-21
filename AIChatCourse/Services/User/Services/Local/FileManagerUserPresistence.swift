//
//  FileManagerUserPresistence.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 21/05/2026.
//

import Foundation


struct FileManagerUserPresistence: LocalUserPresistence {
    let userDocumentKey = "current_user"
    
    func getCurrentUser(key: String) throws -> UserModel? {
        try FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveUeer(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
