//
//  AppViewBuilder.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 07/04/2026.
//
import SwiftUI

struct AppViewBuilder<TabBarView: View, OnboardingView: View>: View {
    var showTabBar: Bool = false
    @ViewBuilder var tabBar: TabBarView
    @ViewBuilder var onboarding: OnboardingView
    var body: some View {
        ZStack {
            if showTabBar {
                tabBar
                    .transition(.move(edge: .trailing))
            } else {
                onboarding
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showTabBar)
    }
}

private struct PreviewView: View {
    @State var tabBar: Bool = false
    var body: some View {
        ZStack {
            AppViewBuilder(
                showTabBar: tabBar,
                tabBar: {
                    ZStack {
                        Color.red.ignoresSafeArea()
                        Text("To be continued")
                    }
                },
                onboarding: {
                    ZStack {
                        Color.blue.ignoresSafeArea()
                        Text("Login Flow")
                    }
                }
            )
        }
        .animation(.smooth, value: tabBar)
        .onTapGesture {
            tabBar.toggle()
        }
    }
}

#Preview {
    PreviewView()
}
