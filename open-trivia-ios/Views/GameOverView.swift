//
//  GameOverView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 11.05.25.
//

import SwiftUI

struct GameOverView: View {
    let score: Int
    let questionCount: Int

    @State private var animatedScore = 0

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("🎉 Score 🎉")
                .font(.largeTitle)
            Text("\(score) / \(questionCount)")
                .font(.largeTitle)
                .contentTransition(.numericText())
                .monospacedDigit()
                .animation(.easeOut(duration: 1), value: animatedScore)
            
            HStack {
                Spacer()
                Text("Tap to play again")
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.top, 50)
            
            Button("Play again") {
//                action: {
//                    
//                }
            }.buttonStyle(.borderedProminent)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animatedScore = score
            }
        }
    }

    init(_ score: Int, _ questionCount: Int) {
        self.score = score
        self.questionCount = questionCount
    }
}

#Preview {
    GameOverView(9, 20)
}
