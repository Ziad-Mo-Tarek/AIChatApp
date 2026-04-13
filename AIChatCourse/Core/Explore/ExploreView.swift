//
//  ExploreView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ExploreView: View {
    let avatar: AvatarModel = AvatarModel.mock
    var body: some View {
        NavigationStack {
            HeroCell(
                title: avatar.name,
                subTitle: avatar.characterDescription,
                imageName: avatar.profileImageName
            )
            .frame(height: 200)
            .navigationTitle(Text("Explore"))
        }
    }
}


#Preview {
    ExploreView()
}
