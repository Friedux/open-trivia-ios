//
//  QuestionView.swift
//  Code History
//
//  Created by Josua Friederichs on 08.05.25.
//

import SwiftUI

struct QuestionView: View {
    @State private var selectedAnswerIndex: Int? = nil
    var question : Question
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question.text)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 10)
            Spacer()
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            @State var padding: Edge.Set = []
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<question.possibleAnswers.count, id: \.self) { answerIndex in
                    Button(
                        action: {
                            print("Tapped on Option \(answerIndex + 1)")
                            selectedAnswerIndex = answerIndex
                        },
                        label: {
                            ChoiceTextView(
                                borderColor: .blue,
                                choiceText: question.possibleAnswers[answerIndex]
                            )
                            .padding((answerIndex % 2 == 0) ? (.leading) : (.trailing), 10)
                            .padding(.horizontal, 10)
                        }
                    )
                }
            }
            Spacer()
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: .init(text: "Test", possibleAnswers: ["A", "B", "C", "D"], rightAnswerIndex: 1))
    }
}
