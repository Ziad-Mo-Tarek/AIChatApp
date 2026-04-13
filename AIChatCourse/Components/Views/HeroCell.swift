//
//  HeroCell.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 13/04/2026.
//

import SwiftUI

struct HeroCell: View {
    var title: String? = "some title will go here"
    var subTitle: String? = "some subtitle will go here"
    var imageName: String? = Constants.randomeImage
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let imageName {
                ImageLoader(urlString: imageName)
            } else {
                Rectangle()
            }
        }
        .overlay(alignment: .bottomLeading){
            VStack(alignment: .leading, spacing: 5) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                
                if let subTitle {
                    Text(subTitle)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.white)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.3),
                    Color.black.opacity(0.5)
                ], startPoint: .top, endPoint: .bottom)
            )
        }
        .cornerRadius(16)
    }
}

#Preview {
    ScrollView {
        VStack {
            HeroCell()
                .frame(width: 300, height: 200)
            HeroCell(imageName: nil)
                .frame(width: 300, height: 200)
            HeroCell(title: nil)
                .frame(width: 300, height: 200)
            HeroCell(subTitle: nil)
                .frame(width: 300, height: 200)
        }
        .frame(maxWidth: .infinity)
    }
    
}
