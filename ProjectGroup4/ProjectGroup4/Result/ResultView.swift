//
//  ResultView.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/12/25.
//
import SwiftUI
import SwiftData


// MARK: View
struct ResultView: View {
    // MARK: state
    @Environment(\.modelContext) private var modelContext

    @State private var isSaved = false
    var results: [QuizResult]
    var correctCount: Int {
        self.results
            .filter { $0.isCorrect == true }
            .count
    }

    
    // MARK: body
    var body: some View {
        VStack {
            CorrectCountLabel
            
            ResultItemList
            
            SaveButton
        }
        .navigationTitle("결과")
    }
    
    private func saveResult() {
        
    }
}


// MARK: Component
extension ResultView {
    var CorrectCountLabel: some View {
        Text("맞춘 개수: \(correctCount)/\(results.count)")
    }
    
    var ResultItemList: some View {
        List(results) { result in
            ResultItemView(result: result)
        }
        .listStyle(.inset)
    }
    
    var SaveButton: some View {
        Button {
            print("SwiftData로 저장")
            
            let newSuite = ResultSuite(results: results, created: Date())
            modelContext.insert(newSuite)
            isSaved = true
            
            print("새로운 ResultSuite가 저장되었습니다. ID: \(newSuite.id)")
        } label: {
            Text(isSaved ? "결과가 저장되었습니다" : "저장하기" )
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSaved ? Color.gray : Color.green)
                .cornerRadius(10)
            
        }
        .padding(.horizontal)
        .padding(.bottom)
        .disabled(isSaved)
    }
}


// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ResultSuite.self, configurations: config)
    
    ResultView(results: [
        QuizResult(image: "사자", answer: "사자", correctAnswer: "사자", isCorrect: true),
        QuizResult(image: "호랑이", answer: "여우", correctAnswer: "호랑이", isCorrect: false)
    ])
        .modelContainer(container)
}
