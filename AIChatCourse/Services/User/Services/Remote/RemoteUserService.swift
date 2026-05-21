//
//  RemoteUserService.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 21/05/2026.
//


protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnboardingCompleted(userId: String, selectedColorHex: String) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}