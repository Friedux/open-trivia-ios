//
//  StartScreenView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 16.05.25.
//

import SwiftUI

struct StartScreenView: View {
    @EnvironmentObject private var appState: AppState
    
    private let mainColor = Color(
        red: 20 / 255,
        green: 28 / 255,
        blue: 58 / 255
    )
    private let textColor = Color.white

    var body: some View {
        ZStack {
            mainColor.ignoresSafeArea()
            Button(action: {
                appState.hasStartedGame = true
            }) {
                Text("Start Game")
            }
        }
        .foregroundStyle(textColor)
    }
}

#Preview {
    StartScreenView()
}
