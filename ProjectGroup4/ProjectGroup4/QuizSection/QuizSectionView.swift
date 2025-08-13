//
//  QuizSectionView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import SwiftUI

struct QuizSectionView: View {
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
    @Binding var toQuizSectionView : Bool
    @Binding var saveSuccessToastMessage : Bool
    @State private var timeRemaining = 10.0
    @State private var timer: Timer?
    
    var body: some View {
        
        VStack{
            HStack(spacing: 20) {
             
                ZStack {
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: 50, height: 50)
                    
                    Text("\(Int(timeRemaining))")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
              
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: 200, height: 20)
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    Rectangle()
                        .frame(width: max(0, 200 * (timeRemaining / 10.0)), height: 20)
                        .foregroundColor(Color.blue)
                }
                .cornerRadius(10)
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
            .onChange(of:timeRemaining){
                if(timeRemaining == 0){
                   if( currentIndex == quizContent.count - 1) {
                       compareAnswer()
                       updateQuizResult()
                       toResultView = true
            
                    }
                    else{
                        compareAnswer()
                        updateQuizResult()
                        currentIndex += 1
                        timeRemaining = 10.0
                        startTimer()
                    }
                }
            }
            
            Text(answerHint)
                .fontWeight(.semibold)
                .font(.title)
            
            Image(currentImage)
                .resizable()
                .scaledToFit()
                .background(.black)
                .frame(width: 300,height: 300)
                .background(.black)
                
            
            
            TextField("정답을 입력하세요", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button{
                if currentIndex == quizContent.count - 1 {
                    compareAnswer()
                    updateQuizResult()
                    toResultView = true
                } else {
                    compareAnswer()
                    updateQuizResult()
                    currentIndex += 1
                    timeRemaining = 10.0
                    startTimer()
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
        .navigationDestination(isPresented: $toResultView, destination: {ResultView(category: category, difficulty: difficulty,results: quizResult, toQuizSectionView: $toQuizSectionView, saveSuccessToastMessage: $saveSuccessToastMessage)})
        
        .onAppear{
            quizContent = QuizData.getData(category: category, difficulty: difficulty)
            print("으음\(quizContent.count)")
            updateQuizData()
        }
        .onChange(of: currentIndex) {
            updateQuizData()
            print("현재:\(currentIndex)")
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    private func updateQuizData() {
        let currentKey = Array(quizContent.keys)[currentIndex]
        currentImage = currentKey
        currentAnswer = quizContent[currentKey] ?? ""
        answerHint = String(repeating: "O", count: currentAnswer.count)
        userInput = ""
    }
    
    private func updateQuizResult() {
        let result = QuizResult(image: currentImage, answer: userInput, correctAnswer: currentAnswer, isCorrect: isCorrect)
        quizResult.append(result)
    }
    
    private func compareAnswer() {
        let user = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        self.isCorrect = user.caseInsensitiveCompare(currentAnswer) == .orderedSame
    }
    
    private func startTimer() {
        timer?.invalidate()
         timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
             if timeRemaining > 0 {
                 timeRemaining -= 0.1
             } else {
                 timer?.invalidate()
                 timeRemaining = 0
             }
         }
     }
    
}

#Preview {
    QuizSectionView(category: .animals, difficulty: .hard, toQuizSectionView: .constant(false), saveSuccessToastMessage: .constant(false))
}
