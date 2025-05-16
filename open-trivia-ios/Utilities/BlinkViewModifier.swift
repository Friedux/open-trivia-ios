//
//  BlinkViewModifier.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 16.05.25.
//

import SwiftUI

struct BlinkViewModifier: ViewModifier {

    let duration: Double
    @State private var blinking: Bool = false

    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0 : 1)
            .animation(.easeOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                withAnimation {
                    blinking = true
                }
            }
    }
}

extension View {
    @ViewBuilder
    func blinking(isBlinking: Bool, duration: Double = 0.75) -> some View {
        if isBlinking {
            self.modifier(BlinkViewModifier(duration: duration))
        } else {
            self  // returns original view
        }
    }
}
