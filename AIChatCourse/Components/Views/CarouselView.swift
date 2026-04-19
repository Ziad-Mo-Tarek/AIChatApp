//
//  CarouselView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 19/04/2026.
//

import SwiftUI

struct CarouselView<Content: View, T: Hashable>: View {
    var items: [T]
    @State private var selection: T?
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ScrollView(.horizontal){
                LazyHStack(spacing: 0){
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .scrollTransition(.interactive.threshold(.visible(0.95)), transition: { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.9)
                            })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            .onAppear {
                updateSelectionIfNeeded()
            }
            .onChange(of: items.count) { oldValue, newValue in
                updateSelectionIfNeeded()
            }
            
            HStack(alignment: .center, spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(item == selection ? .accent : .secondary.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selection)
            
        }
    }
    
    func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
    
}

#Preview {
    CarouselView(items: AvatarModel.mocks) { item in
        HeroCell(
            title: item.name,
            subTitle: item.characterDescription,
            imageName: item.profileImageName
        )
    }
    .padding()
}
