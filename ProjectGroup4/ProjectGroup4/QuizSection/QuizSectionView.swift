//
//  QuizSectionView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import SwiftUI

struct QuizSelectionView: View {
    let category:QuizData.Category
    let difficulty : QuizData.Difficulty
    @State private var quizResult : [QuizResult] = []
    @State private var quizContent : [String : String] = [:]
    @State private var currentIndex : Int = 0
    @State private var currentImage: String = ""
    @State private var currentAnswer: String = ""
    @State private var answerHint: String = ""
    @State private var userInput: String = ""
    @State private var isCorrect : Bool = false
    @State private var toResultView: Bool = false
    
    var body: some View {
    
            VStack{
                Text(answerHint)
                
                Image(currentImage)
                    .resizable()
                    .scaledToFit()
                    
                
                TextField("정답을 입력하세요", text: $userInput)
                                 .textFieldStyle(RoundedBorderTextFieldStyle())
                                 .padding()
                
                Button{
                    if currentIndex == quizContent.count - 1 {
                                         toResultView = true
                                     } else {
                                         compareAnswer()
                                         updateQuizResult()
                                         currentIndex += 1
                                     }
                } label: {
                    if currentIndex == quizContent.count - 1 {
                        Text("결과보기")
                    }
                    else{
                      Text("다음으로")
                    }
               
                }
            }
            .navigationDestination(isPresented: $toResultView, destination: {ResultView(results: quizResult)})
        
        .onAppear{
            quizContent = QuizData.getData(category: category, difficulty: difficulty)
            print("으음\(quizContent.count)")
            updateQuizData()
        }
        .onChange(of: currentIndex) {
                updateQuizData()
            print("현재:\(currentIndex)")
        }
    
    }
    
    
    private func updateQuizData() {
         let currentKey = Array(quizContent.keys)[currentIndex]
         currentImage = currentKey
         currentAnswer = quizContent[currentKey] ?? ""
         answerHint = String(repeating: "O", count: currentAnswer.count)
         userInput = ""
     }
    
    private func updateQuizResult(){
        let result = QuizResult(image: currentImage, answer: userInput, correctAnswer: currentAnswer, isCorrect: isCorrect)
        quizResult.append(result)
    }
    
    private func compareAnswer(){
        let user = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        self.isCorrect = user.caseInsensitiveCompare(currentAnswer) == .orderedSame
    }

}

#Preview {
    QuizSelectionView(category: .animals, difficulty: .medium)
}
