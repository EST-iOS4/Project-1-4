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
    @Query(sort: \ResultSuite.created, order: .reverse) private var resultSuites: [ResultSuite]
    
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
                            NavigationLink {
                                HistoryList(suite: suite)
                            } label: {
                                HistoryRow(suite: suite)
                            }
                        }
                        .onDelete(perform: deleteResult)
                    }
                }
            }
            .navigationTitle("퀴즈 결과")
        }
    }
    
    private func deleteResult(at offsets: IndexSet) {
        for offset in offsets {
            let suite = resultSuites[offset]
            modelContext.delete(suite)
        }
    }
}





// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ResultSuite.self, configurations: config)
    
    let sampleSuite1 = ResultSuite(
        results: [
            QuizResult(image: "사자", answer: "사자", correctAnswer: "사자", isCorrect: true),
            QuizResult(image: "호랑이", answer: "여우", correctAnswer: "호랑이", isCorrect: false)
        ],
        created: .now,
        category: .init(quiz: .animals, level: .easy)
    )
    
    let sampleSuite2 = ResultSuite(
        results: [
            QuizResult(image: "구글", answer: "구글", correctAnswer: "구글", isCorrect: true),
            QuizResult(image: "애플", answer: "삼성", correctAnswer: "���플", isCorrect: false)
        ],
        created: .now.addingTimeInterval(-86400),
        category: .init(quiz: .brands, level: .hard)
    )
    
    container.mainContext.insert(sampleSuite1)
    container.mainContext.insert(sampleSuite2)
    
    return QuizHistoryView()
        .modelContainer(container)
}
