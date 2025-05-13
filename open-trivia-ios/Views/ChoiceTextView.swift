//
//  ChoiceTextView.swift
//  Code History
//
//  Created by Josua Friederichs on 08.05.25.
//

import SwiftUI

struct ChoiceTextView: View {
    var borderColor = Color.blue
    let choiceText: String
    
    var body: some View {
        Text(choiceText)
            .font(.body)
            .bold()
            .multilineTextAlignment(.center)
            .padding()
            .cornerRadius(5)
            .frame(maxWidth: .infinity)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 5))
    }
}

struct ChoiceTextView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceTextView(choiceText: "Choice Text!")
    }
}
