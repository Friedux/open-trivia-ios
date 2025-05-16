//
//  QuestionView.swift
//  Code History
//
//  Created by Josua Friederichs on 08.05.25.
//

import SwiftUI

struct QuestionView: View {
    @Binding public var selectedAnswerIndex: Int?
    var isPressed: Bool
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
                            let isCorrect =
                                answerIndex == question.rightAnswerIndex
                            onAnswerSelected(isCorrect)
                        },
                        label: {
                            let isSelected = selectedAnswerIndex == answerIndex
                            let isCorrect = answerIndex == question.rightAnswerIndex
                            let selectedAnswerIsCorrect = isSelected && isCorrect

                            let borderColor: Color = isSelected
                                ? (isCorrect ? .green : .red)
                                : .blue

                            ChoiceTextView(
                                borderColor: borderColor,
                                choiceText: question.possibleAnswers[
                                    answerIndex
                                ]
                            )
                            .padding(
                                (answerIndex % 2 == 0)
                                    ? (.leading) : (.trailing),
                                10
                            )
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .padding(.horizontal, 10)
                            .blinking(
                                isBlinking: ((isPressed
                                    && !selectedAnswerIsCorrect)
                                    && answerIndex == question.rightAnswerIndex)
                            )
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
            isPressed: false,
            question: .init(
                text: "Test",
                possibleAnswers: ["A", "B", "C", "D"],
                rightAnswerIndex: 1
            ),
            onAnswerSelected: { isCorrect in
                if isCorrect {
                    score += 1
                    print(score)
                }
            }
        )
    }
}
