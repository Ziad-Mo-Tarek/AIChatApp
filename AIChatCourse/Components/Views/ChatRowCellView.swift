//
//  ChatRowCellView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 25/04/2026.
//

import SwiftUI

struct ChatRowCellView: View {
    var imageName: String? = Constants.randomeImage
    var headline: String? = "Alpha"
    var subHeadline: String? = "last message sent in the chat"
    var hasNewChat: Bool = true

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoader(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                if let headline {
                    Text(headline)
                        .font(.headline)
                }
                
                if let subHeadline {
                    Text(subHeadline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewChat {
                Text("NEW")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .cornerRadius(6)
                
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(uiColor: UIColor.systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        List {
            ChatRowCellView()
                .removeListRowFormatting()
            
            ChatRowCellView(hasNewChat: false)
                .removeListRowFormatting()
            
            ChatRowCellView(imageName: nil)
                .removeListRowFormatting()
            
            ChatRowCellView(headline: nil)
                .removeListRowFormatting()

            ChatRowCellView(subHeadline: nil)
                .removeListRowFormatting()
        }
        
    }
    
}
