//
//  CategoryCell.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 20/04/2026.
//

import SwiftUI

struct CategoryCell: View {
    var title: String = "Alien"
    var imageName: String = Constants.randomeImage
    var font: Font = .title2
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        
        ImageLoader(urlString: imageName, contentMode: .fill)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                Text(title)
                    .font(font)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addingBackgroundGradientForText()
            }
            .cornerRadius(cornerRadius)
        
    }
}

#Preview {
    VStack(alignment: .center) {
        CategoryCell()
            .padding()
        
        CategoryCell()
            .padding()
    }
    
}
