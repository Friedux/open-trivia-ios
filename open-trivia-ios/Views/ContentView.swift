//
//  ContentView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 09.05.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameManager = GameManager()
    
    @State private var openTriviaQuestions: [OpenTriviaQuestion] = []
    @State private var index: Int = 0
    @State var isVisible: Bool = false

    private let mainColor = Color(
        red: 20 / 255,
        green: 28 / 255,
        blue: 58 / 255
    )
    private let textColor = Color.white
    private let optionCount = 4

    var body: some View {
        ZStack {
            mainColor.ignoresSafeArea()

            if !gameManager.isGameOver {
                // Show question with options
                if let question = gameManager.currentQuestion {
                    VStack(alignment: .center, spacing: 20) {
                        Text(
                            "\(gameManager.currentIndex + 1) / \(gameManager.questions.count)"
                        )
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding()

                        QuestionView(
                            selectedAnswerIndex: $gameManager
                                .selectedAnswerIndex,
                            isPressed: gameManager.isButtonPressed,
                            question: question,
                            onAnswerSelected: { isCorrect in
                                gameManager.answerSelected(isCorrect: isCorrect)
                            }
                        )
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut, value: gameManager.currentIndex)

                        let isLastQuestion =
                            !(gameManager.currentIndex < gameManager.questions
                            .count - 1)

                        Button(action: {
                            gameManager.goToNextQuestion()
                        }) {
                            Text(
                                isLastQuestion
                                    ? "Show Results" : "Next Question"
                            )
                        }
                        .opacity(
                            (gameManager.selectedAnswerIndex != nil) ? 1 : 0
                        )
                    }
                } else {
                    ProgressView("Loading Questions...")
                }
            } else {
                // Show ResultView when Game is over - Check for Replay-Buttonpress
                ResultView(
                    gameManager.score,
                    gameManager.questions.count,
                    onPlayAgain: {
                        isVisible = false
                        Task {
                            await gameManager.startGame()
                        }
                    }
                )
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1 : 0.95)
                .animation(.smooth(extraBounce: 0.6), value: isVisible)
                .onAppear {
                    isVisible = true
                }
            }
        }
        .foregroundStyle(textColor)
        .task {
            await gameManager.startGame()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameManager = GameManager()
        gameManager.startGame(with: [
            Question(
                text: "What was the first computer bug?",
                possibleAnswers: ["Ant", "Beetle", "Moth", "Fly"],
                rightAnswerIndex: 2
            )
        ])
        return ContentView()
            .environmentObject(gameManager)
    }
}
