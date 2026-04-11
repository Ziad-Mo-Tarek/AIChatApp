//
//  AppState.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

@Observable
class AppState {
    private(set) var showTabBar: Bool {
        didSet {
            UserDefaults.showTabBarView = showTabBar
        }
    }
    
    init(showTabBar: Bool = UserDefaults.showTabBarView) {
        self.showTabBar = showTabBar
    }
    
    func updateShowTabBar(_ showTabBar: Bool) {
        self.showTabBar = showTabBar
    }
}

extension UserDefaults {
    private struct keys {
        static let showTabBar = "showTabBar"
    }
    
    static var showTabBarView : Bool {
        get {
            standard.bool(forKey: keys.showTabBar)
        } set {
            standard.set(newValue, forKey: keys.showTabBar)
        }
    }
    
}
