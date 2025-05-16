//
//  GameManager.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 13.05.25.
//

import Foundation

@MainActor
class GameManager: ObservableObject {
    let amountOfQuestions: Int = 5

    @Published var questions: [Question] = []
    @Published var currentIndex: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    @Published var isButtonPressed : Bool = false

    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    func startGame() async {
        do {

            let openTriviaQuestions = try await OpenTriviaAPIService.shared
                .fetchQuestions(amountOfQuestions)
            self.startGame(
                with: openTriviaQuestions.map(Question.fromOpenTriviaQuestion)
            )
        } catch {
            print("Error while trying to load questions: \(error)")
        }
    }

    func startGame(with questions: [Question]) {
        self.questions = questions
        self.currentIndex = 0
        self.selectedAnswerIndex = nil
        self.score = 0
        self.isGameOver = false
    }

    func answerSelected(isCorrect: Bool) {
        isButtonPressed = true
        if isCorrect {
            score += 1
        }
    }

    func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            selectedAnswerIndex = nil
        } else {
            isGameOver = true
        }
        isButtonPressed = false
    }
}
