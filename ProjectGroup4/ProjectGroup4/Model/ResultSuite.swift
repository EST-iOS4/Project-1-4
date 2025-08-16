//
//  ResultSuite.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/12/25.
//
import Foundation
import SwiftData


@Model
final class ResultSuite {
    @Attribute(.unique)
    var id: UUID
    
    var results: [QuizResult]
    var created: Date
    var formattedCreadted: String {
        return created.formatted(
            .dateTime
                .year().month().day()
                .locale(Locale(identifier: "ko_KR"))
        )

    }
    
    var category: SuiteCategory
    
    init(id: UUID = UUID(), results: [QuizResult], created: Date = .now, category: SuiteCategory) {
        self.id = id
        self.results = results
        self.created = created
        self.category = category
    }
    
    struct SuiteCategory: Codable {
        let quiz: QuizData.Category
        let level: QuizData.Difficulty
    }
}
