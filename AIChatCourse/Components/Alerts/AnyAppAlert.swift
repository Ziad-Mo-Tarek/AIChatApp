//
//  AnyAppAlert.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 03/05/2026.
//
import Foundation
import SwiftUI

struct AnyAppAlert: Sendable {
    let title: String
    let subtitle: String?
    let buttons: @Sendable () -> AnyView
    
    init(title: String, subtitle: String? = nil, buttons: (@Sendable () -> AnyView)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("Ok", action: {
                    
                })
            )
        }
    }
    
    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
    
}

enum AlertType {
    case alert, confirmationDialog
}

extension View {
    
    @ViewBuilder
    func showCustomAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {
        switch type {
        case .alert:
            self
                .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    Text(alert.wrappedValue?.subtitle ?? "")
                }
        case .confirmationDialog:
            self
                .confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let sub = alert.wrappedValue?.subtitle {
                        Text(sub)
                    }
                }
        }
        
        
    }
}
