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
    
    init(id: UUID = UUID(), results: [QuizResult], created: Date = .now) {
        self.id = id
        self.results = results
        self.created = created
    }
}
