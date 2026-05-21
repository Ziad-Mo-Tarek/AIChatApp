//
//  UserManager.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 18/05/2026.
//

import Foundation
import SwiftUI
import SwiftfulUtilities
import FirebaseFirestore

@MainActor
@Observable
class UserManager {
    private let remote: RemoteUserService
    private let local: LocalUserPresistence
    private(set) var currentUser: UserModel?
    private var listener: (any NSObjectProtocol)?
    private var currentUserListener:ListenerRegistration?
    
    init(services: UserServices) {
        self.remote = services.remote
        self.local = services.local
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creaionVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creaionVersion)
        try await remote.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        Task {
            do {
                for try await value in remote.streamUser(userId: userId) {
                    currentUser = value
                    saveCurrentUserLocally()
                    print("Current user updated")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func saveCurrentUserLocally(){
        Task {
            do {
                try local.saveUeer(user: currentUser)
                print("Success saving user locally.")
            } catch {
                print("Error saving user locally: \(error)")
            }
        }
    }
    
    func markOnboardingCompletedForCurrentUser(selectedColorHex: String) async throws {
        let uid = try userId()
        try await remote.markOnboardingCompleted(userId: uid, selectedColorHex: selectedColorHex)
    }
    
    func signOut(){
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let id = try userId()
        try await remote.deleteUser(userId: id)
        signOut()
    }
    
    func userId() throws -> String {
        guard let id = currentUser?.userId else {
            throw UserManagerError.noUserId
        }
        return id
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
    
}
