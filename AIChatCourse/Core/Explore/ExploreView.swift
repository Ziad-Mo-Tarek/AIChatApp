//
//  ExploreView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct ExploreView: View {
    let avatar: AvatarModel = AvatarModel.mock
    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    
    var body: some View {
        NavigationStack {
            List {
                featuredView
                categorySection
               
                
            }
            .navigationTitle("Explore")
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
                        CategoryCell(title: cat.rawValue.capitalized, imageName: Constants.randomeImage)
                            
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
    
}


#Preview {
    ExploreView()
}
