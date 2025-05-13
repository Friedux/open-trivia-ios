//
//  GameManager.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 13.05.25.
//

import Foundation

@MainActor
class GameManager: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentIndex: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false

    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    func startNewGame(with questions: [Question]) {
        self.questions = questions
        self.currentIndex = 0
        self.selectedAnswerIndex = nil
        self.score = 0
        self.isGameOver = false
    }

    func answerSelected(isCorrect: Bool) {
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
    }
}
