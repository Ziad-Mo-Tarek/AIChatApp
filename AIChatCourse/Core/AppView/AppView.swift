//
//  AppView.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 07/04/2026.
//

import SwiftUI

    

struct AppView: View {
    @AppStorage("showTabBar") var tabBar: Bool = false
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
    AppView(tabBar: true)
}

#Preview {
    AppView(tabBar: false)
}
