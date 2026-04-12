//
//  OnboardingColorView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 12/04/2026.
//

import SwiftUI

struct OnboardingColorView: View {
    var profileColors: [Color] = [
        .red, .green, .mint, .cyan, .indigo,.purple, .teal, .gray, .blue
    ]
    @State var selectedColor: Color? = nil
    var body: some View {
        ScrollView {
            colorGrid
                .padding(.horizontal, 16)
        }
        .safeAreaInset(
            edge: .bottom,
            alignment: .center,
            spacing: 16,
            content: {
                if let selectedColor {
                    ZStack {
                        ctaButton
                    }
                    .padding(.horizontal, 24)
                    .background(
                        Color(uiColor: .systemBackground)
                    )
                    .transition(.move(edge: .bottom))
                }
            }
        )
        .animation(.bouncy, value: selectedColor)
    }
    
    private var ctaButton: some View {
        NavigationLink {
            CompletedView()
        } label: {
            Text("Continue")
                .callToActionButton()
        }
    }
    
    
    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
            alignment: .center,
            spacing: 16,
            pinnedViews: .sectionHeaders) {
                Section {
                    ForEach(profileColors, id: \.self) { color in
                        Circle()
                            .fill(.accent)
                            .overlay(content: {
                                Circle()
                                    .fill(color)
                                    .padding(selectedColor == color ? 10 : 0)
                            })
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                } header: {
                    Text("Select a profile color")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                
            }
    }
    
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
}
