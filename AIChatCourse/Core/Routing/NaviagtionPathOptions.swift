//
//  NaviagtionPathOptions.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 10/05/2026.
//

import Foundation
import SwiftUI

enum NaviagtionPathOptions: Hashable {
    case chatView(avatarId: String)
    case category(category: CharacterOption, imageName: String)
}

extension View {
    func navigationDestinationForCoreModeule(path: Binding<[NaviagtionPathOptions]>) -> some View {
        self
            .navigationDestination(for: NaviagtionPathOptions.self) { newValue in
                switch newValue {
                case .chatView(avatarId: let avatarId):
                    ChatView(avatarId: avatarId)
                case .category(category: let category, let imageName):
                    CategoryListView(path: path, category: category, imageName: imageName)
                }
            }
    }
}
