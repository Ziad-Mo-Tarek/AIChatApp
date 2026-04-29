//
//  CreateAccountView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 29/04/2026.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    var title: String = "Create Account?"
    var subTitle: String = "Don't lose your data, connect to an SSO provider to save your account."
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .font(.body)
                
                SignInWithAppleButtonView(
                    type: .signIn,
                    style: .black, cornerRadius: 8)
                    .frame(height: 55)
                    .anyButton(.press) {
                        
                    }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            
            
        }
        .padding(16)
        .padding(.top, 40 )
    }
}

#Preview {
    CreateAccountView()
}
