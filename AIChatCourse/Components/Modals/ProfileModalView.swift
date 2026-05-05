//
//  ProfileModalView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 05/05/2026.
//

import SwiftUI

struct ProfileModalView: View {
    var imageName:String? = Constants.randomeImage
    var title:String? = "Alpha"
    var subTitle:String? = "Alien"
    var headline: String? = "an Alien in the park"
    var onXmarkTapped: () -> Void = { }
    
    var body: some View {
        VStack(spacing: 0){
            if let imageName {
                ImageLoader(urlString: imageName, forceTransitionAnimation: true)
                    .aspectRatio(1, contentMode: .fit)
            }
            VStack(alignment: .leading, spacing: 10) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                if let subTitle {
                    Text(subTitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .cornerRadius(16)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(.black)
                .padding(4)
                .tapableBackgrounf()
                .anyButton {
                    onXmarkTapped()
                }
                .padding(8)
        }
        
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.9).ignoresSafeArea()
        ProfileModalView()
            .padding(40)
    }
    
}
