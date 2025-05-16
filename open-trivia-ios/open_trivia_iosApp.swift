//
//  open_trivia_iosApp.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 09.05.25.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var hasStartedGame: Bool

    init(hasStartedGame: Bool) {
        self.hasStartedGame = hasStartedGame
    }
}

@main
struct open_trivia_iosApp: App {
    @ObservedObject var appState = AppState(hasStartedGame: false)

    var body: some Scene {
        WindowGroup {
            if appState.hasStartedGame {
                GameView()
                    .environmentObject(appState)
            } else {
                StartScreenView()
                    .environmentObject(appState)
            }
        }
    }
}
