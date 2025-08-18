//
//  ResultItemView.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/12/25.
//
import SwiftUI


// MARK: View
struct ResultItemView: View {
    let result: QuizResult
    
    var body: some View {
        HStack(spacing: 15) {
           
         
            Image(result.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
                
            
            VStack(alignment: .leading, spacing: 5) {

                
                HStack {
                    Text("정답:")
                        .font(.caption)
                        .foregroundColor(.primary.opacity(0.7))
                    
                    Text(result.correctAnswer)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
               
                    HStack {
                        Text("입력:")
                            .font(.caption)
                            .foregroundColor(.primary.opacity(0.7))
                     
                            Text(result.answer.isEmpty ? "무응답" : result.answer)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(result.isCorrect ? .green : .red)
                        
                     
                    }
                
            }
            Spacer()
            Image(systemName: result.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title2)
                .foregroundColor(result.isCorrect ? .green : .red)
         
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(result.isCorrect ? Color.green.opacity(0.3) : Color.red.opacity(0.3), lineWidth: 1)
        )
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
