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
import SwiftfulFirestore

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnboardingCompleted(userId: String, selectedColorHex: String) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}

struct MockUserService: UserService {
    
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

struct FirebaseUserService: UserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String, selectedColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnBoarding: true,
            UserModel.CodingKeys.profileColorHex: selectedColorHex
        ])
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}

@MainActor
@Observable
class UserManager {
    private let service: UserService
    private(set) var currentUser: UserModel?
    private var listener: (any NSObjectProtocol)?
    private var currentUserListener:ListenerRegistration?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creaionVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creaionVersion)
        try await service.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        Task {
            do {
                for try await value in service.streamUser(userId: userId) {
                    currentUser = value
                    print("Current user updated")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func markOnboardingCompletedForCurrentUser(selectedColorHex: String) async throws {
        let uid = try userId()
        try await service.markOnboardingCompleted(userId: uid, selectedColorHex: selectedColorHex)
    }
    
    func signOut(){
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let id = try userId()
        try await service.deleteUser(userId: id)
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
