//
//  QuestionView.swift
//  Code History
//
//  Created by Josua Friederichs on 08.05.25.
//

import SwiftUI

struct QuestionView: View {
    @Binding public var selectedAnswerIndex: Int?
    var question: Question
    var onAnswerSelected: (Bool) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(question.text)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .minimumScaleFactor(0.5)
                .frame(height: 120)
                .padding(.horizontal, 10)
            Spacer()

            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<question.possibleAnswers.count, id: \.self) {
                    answerIndex in
                    Button(
                        action: {
                            selectedAnswerIndex = answerIndex
                            let isCorrect = answerIndex == question.rightAnswerIndex
                            onAnswerSelected(isCorrect)
                        },
                        label: {
                            ChoiceTextView(
                                borderColor: selectedAnswerIndex == answerIndex
                                    ? (answerIndex == question.rightAnswerIndex
                                        ? Color.green : Color.red)
                                    : Color.blue,
                                choiceText: question.possibleAnswers[
                                    answerIndex
                                ]
                            )
                            .padding(
                                (answerIndex % 2 == 0)
                                    ? (.leading) : (.trailing),
                                10
                            )
                            .padding(.horizontal, 10)
                        }
                    )
                    .disabled(selectedAnswerIndex != nil)
                }
            }
            Spacer()
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        @State var score: Int = 0
        @State var selectedAnswerIndex: Int? = nil
        QuestionView(
            selectedAnswerIndex: $selectedAnswerIndex,
            question: .init(
                text: "Test",
                possibleAnswers: ["A", "B", "C", "D"],
                rightAnswerIndex: 1
            ), onAnswerSelected: { isCorrect in
                if isCorrect {
                    score += 1
                    print(score)
                }
            }
        )
    }
}
