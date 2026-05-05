//
//  ExploreView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

enum NaviagtionPathOptions: Hashable {
    case chatView(avatarId: String)
    case category(category: CharacterOption, imageName: String)
}

struct ExploreView: View {
    let avatar: AvatarModel = AvatarModel.mock
    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popularAvatars: [AvatarModel] = AvatarModel.mocks
    
    @State private var path: [NaviagtionPathOptions] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                featuredView
                categorySection
                popularSection
            }
            .navigationTitle("Explore")
            .navigationDestination(for: NaviagtionPathOptions.self) { newValue in
                switch newValue {
                case .chatView(avatarId: let avatarId):
                    ChatView(avatarId: avatarId)
                case .category(category: let category, let imageName):
                    CategoryListView(category: category, imageName: imageName)
                }
            }
        }
        
    }
    
    private var featuredView: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { avatar in
                    HeroCell(
                        title: avatar.name,
                        subTitle: avatar.characterDescription,
                        imageName: avatar.profileImageName
                    )
                    .anyButton {
                        onFeaturePressed(avatar: avatar)
                    }
                }
            }
        } header: {
            Text("Featured Avatars")
        }
        .removeListRowFormatting()
    }
    
    private var categorySection: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 12) {
                    ForEach(categories, id: \.self) { cat in
                        let imageName = popularAvatars.first(where: { $0.characterOption == cat })?.profileImageName
                        if let imageName {
                            CategoryCell(title: cat.plural.capitalized, imageName: Constants.randomeImage)
                                .anyButton {
                                    onCategoryPressed(
                                        category: cat,
                                        imageName: imageName
                                    )
                                }
                        }
                    }
                }
            }
            .frame(height: 150)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            
        } header: {
            Text("Categories")
        }
        .removeListRowFormatting()
    }
    
    private var popularSection: some View {
        Section {
            ForEach(popularAvatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton(.highlight, action: {
                    onFeaturePressed(avatar: avatar)
                })
                .removeListRowFormatting()
            }
        } header: {
            Text("Popular")
        }
    }
    
    private func onFeaturePressed(avatar: AvatarModel) {
        path.append(.chatView(avatarId: avatar.avatarId))
    }
    
    private func onCategoryPressed(category: CharacterOption, imageName: String) {
        path.append(.category(category: category, imageName: imageName))
    }
    
}


#Preview {
    NavigationStack {
        ExploreView()
    }
}
