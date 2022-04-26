//
//  NotificationButton.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

struct NotificationButton<Content>: View where Content: View {
    let isEnabled: Bool
    let action: () -> Void
    let content: Content
    
    init(
        isEnabled: Bool = true,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.isEnabled = isEnabled
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action, label: {
            content
        })
        .disabled(!isEnabled)
        .buttonStyle(Style())
    }
}

extension NotificationButton {
    struct Style: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.small)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
            .scaleOpacityEffect(configuration.isPressed)
        }
    }
}
