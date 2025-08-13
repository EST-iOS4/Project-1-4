//
//  HistoryRow.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/13/25.
//
import SwiftUI
import SwiftData


// MARK: View
struct HistoryRow: View {
    // MARK: state
    let suite: ResultSuite
    
    private var correctCount: Int {
        suite.results.filter { $0.isCorrect }.count
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("퀴즈: \(suite.category.quiz.name)")
                Text("난이도: \(suite.category.level.name)")
                Text("점수: \(correctCount) / \(suite.results.count)")
            }
            Spacer()
            Text(suite.created, style: .date)
        }
    }
}
