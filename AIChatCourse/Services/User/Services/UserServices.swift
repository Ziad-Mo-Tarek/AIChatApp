//
//  UserServices.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 21/05/2026.
//


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