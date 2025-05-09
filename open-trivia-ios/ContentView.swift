//
//  ContentView.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 09.05.25.
//

import SwiftUI

struct ContentView: View {
    private let question: Question? = nil
    private let mainColor = Color(
        red: 20 / 255,
        green: 28 / 255,
        blue: 58 / 255
    )
    private let textColor = Color.white
    private let optionCount = 4

    @State private var openTriviaQuestions: [OpenTriviaQuestion]?
    private var index: Int = 0

    init(previewQuestions: [OpenTriviaQuestion]? = nil) {
        self._openTriviaQuestions = State(initialValue: previewQuestions)
    }

    var body: some View {
        ZStack {
            mainColor.ignoresSafeArea()

            if let questions = openTriviaQuestions {
                VStack(alignment: .center, spacing: 20) {
                    Text("\(index + 1) / \(questions.count)")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding()

                    QuestionView(
                        question: Question.fromOpenTriviaQuestion(
                            questions[index]
                        )
                    )
                }
            } else {
                ProgressView("Loading Questions...")
            }
        }
        .foregroundStyle(textColor)
        .task {
            do {
                openTriviaQuestions = try await performApiCall()
            } catch {
                print("Error while trying to load questions: \(error)")
                openTriviaQuestions = nil
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
        let previewQuestion = OpenTriviaQuestion(
            type: "multiple",
            difficulty: "easy",
            category: "History",
            question: "What was the first computer bug?",
            correct_answer: "Moth",
            incorrect_answers: ["Ant", "Beetle", "Fly"]
        )

        ContentView(previewQuestions: [previewQuestion])
    }
}
