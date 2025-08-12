//
//  ResultItemView.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/12/25.
//
import SwiftUI


// MARK: View
struct ResultItemView: View {
    // MARK: state
    let result: QuizResult

    
    // MARK: body
    var body: some View {
        HStack {
            QuizImage

            Answers

            Spacer()

            ResultIcon
        }
        .padding()
    }
}


// MARK: Components
extension ResultItemView {
    var QuizImage: some View {
        Image(result.image)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .padding(.trailing, 10)
    }
    
    var Answers: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("제출 답안: \(result.answer)")
                .font(.headline)
            Text("정답: \(result.correctAnswer)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var ResultIcon: some View {
        if result.isCorrect {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.title)
        } else {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
                .font(.title)
        }
    }
}



// MARK: Preview
#Preview(traits: .sizeThatFitsLayout) {
    let result = QuizResult(image: "개", answer: "개", correctAnswer: "개", isCorrect: true)
    ResultItemView(result: result)
}

#Preview(traits: .sizeThatFitsLayout) {
    let result = QuizResult(image: "고양이", answer: "개", correctAnswer: "고양이", isCorrect: false)
    ResultItemView(result: result)
}
