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
        GeometryReader { geometry in
            ZStack {
               
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.purple.opacity(0.8),
                        Color.blue.opacity(0.6),
                        Color.cyan.opacity(0.4)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 160, height: 160)
                    .offset(x: -70, y: -120)
                
                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 100, height: 100)
                    .offset(x: 90, y: 180)
                
                ScrollView {
                    VStack(spacing: 30) {
                       
                        VStack(spacing: 20) {
                         
                            HStack(spacing: 15) {
                                Image(systemName: "brain.head.profile")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                
                                Text("퀴즈 진행 중")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("\(currentIndex + 1)/\(quizContent.count)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.2))
                                    )
                            }
                            .padding(.horizontal, 25)
                            
                       
                            HStack(spacing: 20) {
                               
                                ZStack {
                                    Circle()
                                        .stroke(Color.white.opacity(0.3), lineWidth: 6)
                                        .frame(width: 70, height: 70)
                                    
                                    Circle()
                                        .trim(from: 0, to: timeRemaining / 10.0)
                                        .stroke(
                                            timeRemaining > 5 ? Color.green : (timeRemaining > 2 ? Color.orange : Color.red),
                                            style: StrokeStyle(lineWidth: 6, lineCap: .round)
                                        )
                                        .frame(width: 70, height: 70)
                                        .rotationEffect(.degrees(-90))
                                        .animation(.linear(duration: 0.1), value: timeRemaining)
                                    
                                    Text("\(Int(timeRemaining))")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                
                       
                                VStack(spacing: 8) {
                                    Text("남은 시간")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: 200, height: 25)
                                            .foregroundColor(Color.white.opacity(0.2))
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: max(0, 200 * (timeRemaining / 10.0)), height: 25)
                                            .foregroundColor(
                                                timeRemaining > 5 ? Color.green : (timeRemaining > 2 ? Color.orange : Color.red)
                                            )
                                            .animation(.linear(duration: 0.1), value: timeRemaining)
                                    }
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                        .padding(.top, 20)
                        
                    
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                    .font(.title3)
                                    .foregroundColor(.yellow.opacity(0.9))
                                
                                Text("힌트")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            
                            Text(answerHint)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.15))
                                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 25)
                        
                     
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "photo.fill")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                                Text("문제 이미지")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            
                            Image(currentImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: min(geometry.size.width - 50, 320), height: min(geometry.size.width - 50, 320))
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                )
                                .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
                        }
                        .padding(.horizontal, 25)
                        
                  
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                                Text("답안 입력")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            
                            TextField("정답을 입력하세요", text: $userInput)
                                .font(.body)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 18)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.9))
                                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                                )
                        }
                        .padding(.horizontal, 25)
                        
                   
                        Button(action: {
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
                        }) {
                            HStack(spacing: 15) {
                                Image(systemName: currentIndex == quizContent.count - 1 ? "checkmark.circle.fill" : "arrow.right.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                
                                Text(currentIndex == quizContent.count - 1 ? "결과보기" : "다음으로")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 25)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                currentIndex == quizContent.count - 1
                                                    ? Color.green.opacity(0.9)
                                                    : Color.blue.opacity(0.9),
                                                currentIndex == quizContent.count - 1
                                                    ? Color.teal.opacity(0.8)
                                                    : Color.indigo.opacity(0.8)
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .onChange(of: timeRemaining) {
            if timeRemaining == 0 {
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
            }
        }
        .navigationDestination(isPresented: $toResultView, destination: {
            ResultView(category: category, difficulty: difficulty, results: quizResult, toQuizSectionView: $toQuizSectionView, saveSuccessToastMessage: $saveSuccessToastMessage)
        })
        .onAppear {
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
    QuizSectionView(category: .celebrities, difficulty: .hard, toQuizSectionView: .constant(false), saveSuccessToastMessage: .constant(false))
}
