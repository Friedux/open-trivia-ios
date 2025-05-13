//
//  GameOverView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 11.05.25.
//

import SwiftUI

struct GameOverView: View {
    let score: Int
    
    var body: some View {
        Text("Game Over! :) Score: \(score)")
    }
    
    init(_ score: Int) {
        self.score = score
    }
}

#Preview {
    GameOverView(20)
}
