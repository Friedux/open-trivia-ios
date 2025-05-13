//
//  GameOverView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 11.05.25.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    let questionCount: Int
    let onPlayAgain: () -> Void

    @State private var animatedScore = 0

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("🎉 Score 🎉")
                .font(.largeTitle)
            Text("\(animatedScore) / \(questionCount)")
                .contentTransition(.numericText())
                .font(.largeTitle)
                .monospacedDigit()
                .animation(.easeOut(duration: 1), value: animatedScore)
                .onAppear {
                    withAnimation {
                        animatedScore = score
                    }
                }

            HStack {
                Spacer()
                Text("Tap to play again")
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.top, 50)

            Button("Play again") {
                onPlayAgain()
            }.buttonStyle(.borderedProminent)
        }
    }

    init(
        _ score: Int,
        _ questionCount: Int,
        onPlayAgain: @escaping () -> Void
    ) {
        self.score = score
        self.questionCount = questionCount
        self.onPlayAgain = onPlayAgain
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(10, 20, onPlayAgain: {})
    }
}
