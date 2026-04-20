//
//  CustomListCellView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 20/04/2026.
//

import SwiftUI

struct CustomListCellView: View {
    var imageName: String? = Constants.randomeImage
    var title: String? = "default title"
    var subtitle: String? = "default subtitle"
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack(content: {
                if let imageName {
                    ImageLoader(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.gray.opacity(0.5))
                }
            })
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(16)
            .frame(height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(12)
        .padding(.vertical, 4)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            CustomListCellView()
            CustomListCellView(imageName: nil)
            CustomListCellView(title: nil)
            CustomListCellView(subtitle: nil)
        }
            
    }
    
}
