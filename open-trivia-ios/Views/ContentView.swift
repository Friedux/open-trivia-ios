//
//  ContentView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 09.05.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedAnswerIndex: Int? = nil
    @State private var score: Int = 0
    @State private var isGameOver: Bool = false
    @State private var isRunning: Bool = false
    @State private var questions: [Question] = []

    private let mainColor = Color(
        red: 20 / 255,
        green: 28 / 255,
        blue: 58 / 255
    )
    private let textColor = Color.white
    private let optionCount = 4

    @State private var index: Int = 0

    // With Questions - e.g. for Preview
    init(previewQuestions: [Question]) {
        self._questions = State(initialValue: previewQuestions)
    }

    // Without Questions - Default
    init() {}

    var body: some View {
        ZStack {
            mainColor.ignoresSafeArea()

            if isGameOver {
                // TODO: show result screen
                GameOverView(score)
            } else {
                // Show question with options
                if !questions.isEmpty {
                    VStack(alignment: .center, spacing: 20) {
                        Text("\(index + 1) / \(questions.count)")
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .padding()

                        QuestionView(
                            selectedAnswerIndex: $selectedAnswerIndex,
                            question: questions[index],
                            onAnswerSelected: { isCorrect in
                                if isCorrect {
                                    score += 1
                                    print(score)
                                }
                            }
                        )

                        Button(
                            action: {
                                if index < questions.count - 1 {
                                    index += 1
                                    selectedAnswerIndex = nil
                                } else {
                                    isGameOver = true
                                }
                            },
                            label: {
                                Text("Next Question")
                            }
                        )
                        .opacity((selectedAnswerIndex != nil) ? 1 : 0)
                    }
                } else {
                    ProgressView("Loading Questions...")
                }
            }
        }
        .foregroundStyle(textColor)
        .task {
            do {
                let openTriviaQuestions = try await performApiCall()
                questions = openTriviaQuestions.map(
                    Question.fromOpenTriviaQuestion
                )
            } catch {
                print("Error while trying to load questions: \(error)")
            }
        }
    }

    func performApiCall() async throws -> [OpenTriviaQuestion] {
        let url = "https://opentdb.com/api.php?amount=10"
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: url)!
        )
        let openTriviaResults = try JSONDecoder().decode(
            OpenTriviaResults.self,
            from: data
        )
        return openTriviaResults.results
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let previewQuestion = Question(
            text: "What was the first computer bug?",
            possibleAnswers: ["Ant", "Beetle", "Fly"],
            rightAnswerIndex: 0
        )

        ContentView(previewQuestions: [previewQuestion])
    }
}
