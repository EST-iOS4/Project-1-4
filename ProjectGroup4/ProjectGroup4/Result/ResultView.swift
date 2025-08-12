import SwiftUI


// MARK: View
struct ResultView: View {
    // MARK: state
    let results: [QuizResult]
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
}


// MARK: Components
extension ResultView {
    var CorrectCountLabel: some View {
        Text("맞춘 개수 : \(correctCount)/\(results.count)")
    }
    
    var ResultItemList: some View {
        List(results, id: \.image) { result in
            ResultItemView(result: result)
        }
        .listStyle(.inset)
    }
    
    var SaveButton: some View {
        Button {
            print("SwiftData로 저장 구현 예정")
        } label: {
            Text("저장하기")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}


// MARK: Preview
#Preview {
    let testResults: [QuizResult] = [
        QuizResult(image: "개", answer: "개", correctAnswer: "개", isCorrect: true),
        QuizResult(image: "고양이", answer: "개", correctAnswer: "고양이", isCorrect: false),
        QuizResult(image: "거북", answer: "거북", correctAnswer: "거북", isCorrect: true),
        QuizResult(image: "기린", answer: "사자", correctAnswer: "기린", isCorrect: false),
        QuizResult(image: "돼지", answer: "돼지", correctAnswer: "돼지", isCorrect: true)
    ]
    
    ResultView(results: testResults)
}
