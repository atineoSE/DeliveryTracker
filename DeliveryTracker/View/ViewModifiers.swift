//
//  ViewModifiers.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

extension View {
    func card(width: CGFloat, height: CGFloat) -> some View {
        self
            .padding(.small)
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .strokeBorder(Color.label, lineWidth: .lineWidth)
                    .background(Color.cardBackground)
                    .clipped()
            )
            .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
    }
    
    func scaleOpacityEffect(_ isPressed: Bool) -> some View {
        withAnimation(.easeInOut) {
            self
                .scaleEffect(isPressed ? 0.95 : 1)
                .opacity(isPressed ? 0.9 : 1)
        }
    }
}
