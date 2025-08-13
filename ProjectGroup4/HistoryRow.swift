import SwiftUI
import SwiftData

struct HistoryRow: View {
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