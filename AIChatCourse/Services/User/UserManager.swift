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

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
}

struct FirebaseUserService: UserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
}

@MainActor
@Observable
class UserManager {
    private let service: UserService
    private(set) var currentUser: UserModel?
    private var listener: (any NSObjectProtocol)?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creaionVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creaionVersion)
        try await service.saveUser(user: user)
    }
    
}
