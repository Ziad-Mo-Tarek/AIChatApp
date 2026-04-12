//
//  OnboardingIntroView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 12/04/2026.
//

import SwiftUI

struct OnboardingIntroView: View {
    var body: some View {
        VStack {
            Group {
                Text("Make you own ")
                +
                Text("avatars ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("and chat with them!\nHave ")
                +
                Text("real conversation ")
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                +
                Text("with your AI generated responses.")
                    .font(.title3)
            }
            .baselineOffset(6)
            .frame(maxHeight: .infinity)
            .padding(24)
            
            NavigationLink {
                OnboardingColorView()
            } label: {
                Text("Continue")
                    .callToActionButton()
            }
            
        }
        .toolbar(.hidden, for: .navigationBar)
        .padding(24)
    }
}

#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
