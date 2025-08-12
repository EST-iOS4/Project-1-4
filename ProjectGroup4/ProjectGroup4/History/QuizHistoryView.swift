//
//  QuizHistoryView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//
import SwiftUI
import SwiftData


// MARK: View
struct QuizHistoryView: View {
    // MARK: state
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ResultSuite.created, order: .forward) private var resultSuites: [ResultSuite]
    
    // MARK: body
    var body: some View {
        NavigationStack {
            VStack {
                // 저장된 결과가 없을 때 안내 메시지 표시
                if resultSuites.isEmpty {
                    ContentUnavailableView("저장된 결과가 없습니다", systemImage: "doc.text.magnifyingglass")
                } else {
                    // 저장된 결과 목록 표시
                    List {
                        ForEach(resultSuites) { suite in
                            Text("구현 예정")
                        }
                    }
                }
            }
            .navigationTitle("퀴즈 결과")
        }
    }
}



// MARK: Preview
#Preview {
    Text("Preview 구현 예정")
}
