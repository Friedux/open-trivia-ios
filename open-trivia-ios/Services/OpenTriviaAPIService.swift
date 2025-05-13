//
//  OpenTriviaAPIService.swift
//  open-trivia-ios
//
//  Created by Josua Friederichs on 13.05.25.
//

import Foundation

struct OpenTriviaAPIService {
    static let shared = OpenTriviaAPIService()
    private let baseURL = "https://opentdb.com/api.php"

    func fetchQuestions(_ amount: Int = 10) async throws -> [OpenTriviaQuestion] {
        guard let url = URL(string: "\(baseURL)?amount=\(amount)")
        else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(
            OpenTriviaResults.self,
            from: data
        )
        return result.results
    }

}
