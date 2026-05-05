//
//  ChatBubbleView.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 03/05/2026.
//

import SwiftUI

struct ChatBubbleView: View {
    var text: String = "this is sample text."
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray5)
    var imageName: String?
    var showImage: Bool = true
    let offset: CGFloat = 14
    var onImagePressed: (() -> ())?
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoader(urlString: imageName, contentMode: .fill)
                            .anyButton {
                                onImagePressed?()
                            }
                    } else {
                        Rectangle()
                            .fill(.gray)
                    }
                }
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .offset(y: offset)
            }
            
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(6)
                .padding(.bottom, offset)
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing :10){
            ChatBubbleView(text: "short text")
            ChatBubbleView(text: "long text to test the word wrapping and the line break in the bubble view to see how it looks like in the real app and how it will be displayed in the real app")
            ChatBubbleView(textColor: .white, backgroundColor: .accent, imageName: nil, showImage: false)
            ChatBubbleView(text: "long text to test the word wrapping and the line break in the bubble view to see how it looks like in the real app and how it will be displayed in the real app", textColor: .white, backgroundColor: .accentColor, imageName: nil, showImage: false)
        }
        .padding()
    }
}
