//
//  AIChatCourseApp.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 05/04/2026.
//

import SwiftUI
import Firebase

@main
struct AIChatCourseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.dependancies.authManager)
                .environment(delegate.dependancies.userManager)
                .environment(delegate.dependancies.aiManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependancies: Dependancies!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        dependancies = Dependancies()
        return true
    }
}


@MainActor
struct Dependancies {
    let authManager: AuthManager
    let userManager: UserManager
    let aiManager: AiManager
    
    init() {
        authManager = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(services: ProductionUserServices())
        aiManager = AiManager(service: OpenAiService())
    }
    
}
