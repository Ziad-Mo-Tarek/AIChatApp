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


protocol LocalUserPresistence: Sendable {
    func getCurrentUser(key: String) throws -> UserModel?
    func saveUeer(user: UserModel?) throws
}

struct FileManagerUserPresistence: LocalUserPresistence {
    let userDocumentKey = "current_user"
    
    func getCurrentUser(key: String) throws -> UserModel? {
        try FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveUeer(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}

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


protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnboardingCompleted(userId: String, selectedColorHex: String) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}

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

struct FirebaseUserService: RemoteUserService {
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

protocol UserServices {
    var local : LocalUserPresistence { get }
    var remote : RemoteUserService { get }
    
}

struct MockUserServices: UserServices {
    let remote: RemoteUserService
    let local: LocalUserPresistence
    
    init(user: UserModel? = nil) {
        self.local = MockUserPresistence(currentUser: user)
        self.remote = MockUserService(currentUser: user)
    }
}


struct ProductionUserServices: UserServices {
    let remote: RemoteUserService = FirebaseUserService()
    let local: LocalUserPresistence = FileManagerUserPresistence()
}


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
