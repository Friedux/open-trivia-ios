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
    
    static func fromOpenTriviaQuestion(_ openTriviaQuestion: OpenTriviaQuestion) -> Question {
        let decodedCorrect = String(htmlEncodedString: openTriviaQuestion.correct_answer) ?? ""
        let decodedIncorrect = openTriviaQuestion.incorrect_answers.map {
            String(htmlEncodedString: $0) ?? ""
        }
        
        let possibleAnswers = (decodedIncorrect + [decodedCorrect]).shuffled()
        return Question(
            text: String(htmlEncodedString: openTriviaQuestion.question) ?? "Missing Question Text!",
            possibleAnswers: possibleAnswers,
            rightAnswerIndex: possibleAnswers.firstIndex(of: decodedCorrect)!
        )
    }
}
