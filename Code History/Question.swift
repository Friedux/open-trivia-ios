//
//  Question.swift
//  Code History
//
//  Created by Josua Friederichs on 08.05.25.
//

import Foundation

struct Question {
    var text: String
    var possibleAnswers: [String]
    var rightAnswerIndex: Int
    
    static func fromOpenTriviaQuestion(_ question: OpenTriviaQuestion) -> Question {
        return Question(
            text: question.question,
            possibleAnswers: question.incorrect_answers + [question.correct_answer],
            rightAnswerIndex: question.incorrect_answers.count
        )
    }
}
