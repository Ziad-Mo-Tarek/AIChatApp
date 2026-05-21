//
//  LocalUserPresistence.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 21/05/2026.
//


protocol LocalUserPresistence: Sendable {
    func getCurrentUser(key: String) throws -> UserModel?
    func saveUeer(user: UserModel?) throws
}