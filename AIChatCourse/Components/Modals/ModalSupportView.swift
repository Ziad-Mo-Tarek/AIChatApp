//
//  ModalSupportView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 05/05/2026.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
    @Binding var showProfileModal: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
             if showProfileModal {
                 Color(.black)
                     .opacity(0.6)
                     .ignoresSafeArea()
                     .transition(AnyTransition.opacity.animation(.smooth))
                     .onTapGesture {
                         showProfileModal = false
                     }
                     .zIndex(1)
                 content
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .ignoresSafeArea()
                     .zIndex(2)
             }
         }
        .zIndex(8989)
        .animation(.bouncy, value: showProfileModal)
    }
}

extension View {
    func showModal(showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
        self
            .overlay {
                ModalSupportView(showProfileModal: showModal) {
                    content()
                }
            }
    }
}

fileprivate struct PreviewView : View {
    @State var showModal: Bool = false
    var body: some View {
        Button("CLikc") {
            showModal = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .showModal(showModal: $showModal) {
            Text("kenfeknfkenf")
                .transition(.slide)
        }
    }
}

#Preview {
    PreviewView()
}
