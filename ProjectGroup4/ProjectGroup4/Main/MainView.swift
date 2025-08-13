//
//  MainView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import SwiftUI

struct MainView: View {
    @State private var toMainView: Bool = false
    @State private var showQuizSetting: Bool = false
    @State var toQuizSectionView : Bool = false
    @State var toQuizHistoryView : Bool = false
    @State var category : QuizData.Category = .animals
    @State var difficulty : QuizData.Difficulty = .easy
    @State var saveSuccessToastMessage : Bool = false
    var body: some View {
        
        NavigationStack {
            if(toMainView == false) {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                            toMainView = true
                        }
                    }
            }
            else {
                ZStack{
                    VStack(spacing: 50) {
                        
                        PrimaryButton(title: "✨퀴즈 시작") {
                            showQuizSetting = true
                        }
                        .padding(.horizontal)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        
                        
                        PrimaryButton(title: "✨지난 결과") {
                            showQuizSetting = true
                        }
                        .padding(.horizontal)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                    
                    
                    if(saveSuccessToastMessage){
                        ToastMessage(message: "저장 완료되었습니다")
                    }
                }
                .sheet(isPresented: $showQuizSetting){
                    QuizSettingView(selectedCategory: $category, selectedDifficulty: $difficulty,toQuizSectionView: $toQuizSectionView)
                }
                .navigationDestination(isPresented: $toQuizSectionView, destination: {QuizSectionView(category: category, difficulty: difficulty,toQuizSectionView: $toQuizSectionView, saveSuccessToastMessage: $saveSuccessToastMessage)})
                .navigationDestination(isPresented:$toQuizHistoryView , destination: {QuizHistoryView()})
                .onChange(of:toQuizSectionView){
                    print(toQuizSectionView)
                }
            }
        }
    }
}
#Preview {
    MainView()
}

