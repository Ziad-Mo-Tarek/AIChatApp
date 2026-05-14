//
//  CreateAccountView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 29/04/2026.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.authService) private var authService
    var title: String = "Create Account?"
    var subTitle: String = "Don't lose your data, connect to an SSO provider to save your account."
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?
    
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
                        onSignInApplePressed()
                    }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            
            
        }
        .padding(16)
        .padding(.top, 40 )
    }
    
    func onSignInApplePressed() {
        Task {
            do {
                let result = try await authService.signInWithApple()
                
                print("Did sign in with apple!")
                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch {
                print("Error signing in with apple: \(error)")
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
