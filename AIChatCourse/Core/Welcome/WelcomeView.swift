//
//  WelcomeView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageName: String = Constants.randomeImage
    var body: some View {
        NavigationStack {
            VStack(spacing: 8){
                ImageLoader(urlString: imageName)
//                    .frame(height: UIScreen.main.bounds.height * 2/3)
                    .ignoresSafeArea()
                
                contentsView

            }
            
        }
    }
    
    var contentsView: some View {
        VStack(alignment: .center, spacing: 8) {
            titleSection
            
            ctaSection
            
            ploicyLinks
            
        }
        .padding(16)
    }
    
    private var titleSection: some View {
       Group {
            Text("AI Chat 🐳")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Youtube @ SwiftforBeginners")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    
    private var ctaSection: some View {
        Group {
            NavigationLink {
                CompletedView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            
            Text("Already have an account? Sign in!")
                .underline()
                .font(.body)
                .padding(8)
                .tapableBackgrounf()
                .onTapGesture {
                    
                }
        }
    }
    
    private var ploicyLinks: some View {
        HStack(spacing: 10){
            
            Link(destination: URL(string: Constants.termsAndConditions)!) {
                Text("Terms of service")
            }
            
            Circle()
                .frame(width: 4, height: 4)
                .foregroundStyle(.accent)
            Link(destination: URL(string: Constants.privacyPolicyUrl)!) {
                Text("Privacy Ploicy")
            }
        }
    }
    
}

#Preview {
    WelcomeView()
}
