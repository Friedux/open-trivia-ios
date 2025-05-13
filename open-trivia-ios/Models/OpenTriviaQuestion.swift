//
//  OpenTriviaQuestion.swift
//  Code History
//
//  Created by Josua Friederichs on 08.05.25.
//

import Foundation

struct OpenTriviaQuestion : Codable {
    var type: String
    var difficulty: String
    var category: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}
