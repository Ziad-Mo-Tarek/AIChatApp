//
//  CategoryListView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 05/05/2026.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var path: [NaviagtionPathOptions]
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomeImage
    @State private var avatars: [AvatarModel] = AvatarModel.mocks
    
    var body: some View {
        List {
            CategoryCell(
                title: category.plural.capitalized,
                imageName: imageName,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            
            ForEach(avatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton(.highlight){
                    onAvatarPressed(avatar: avatar)
                }
                .removeListRowFormatting()
            }
            
        }
        .ignoresSafeArea()
        .listStyle(PlainListStyle())
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chatView(avatarId: avatar.avatarId))
    }
    
}

#Preview {
    CategoryListView(path: .constant([]))
}
