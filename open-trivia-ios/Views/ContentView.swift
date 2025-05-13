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

    private let mainColor = Color(
        red: 20 / 255,
        green: 28 / 255,
        blue: 58 / 255
    )
    private let textColor = Color.white
    private let optionCount = 4

    @State private var index: Int = 0

    // With Questions - e.g. for Preview
    //    init(previewQuestions: [Question]) {
    //        self._questions = State(initialValue: previewQuestions)
    //    }

    // Without Questions - Default
    init() {}

    var body: some View {
        ZStack {
            mainColor.ignoresSafeArea()

            if gameManager.isGameOver {
                GameOverView(gameManager.score, gameManager.questions.count)
            } else {
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
                            question: question,
                            onAnswerSelected: { isCorrect in
                                gameManager.answerSelected(isCorrect: isCorrect)
                            }
                        )

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
            }
        }
        .foregroundStyle(textColor)
        .task {
            do {
                let openTriviaQuestions = try await OpenTriviaAPIService.shared
                    .fetchQuestions(amount: 10)
                gameManager.startNewGame(
                    with: openTriviaQuestions.map(Question.fromOpenTriviaQuestion)
                )
            } catch {
                print("Error while trying to load questions: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameManager = GameManager()
        gameManager.startNewGame(with: [
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
