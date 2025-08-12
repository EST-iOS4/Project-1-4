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
    var body: some View {
        
        ZStack {
            if(toMainView == false) {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                            toMainView = true
                        }
                    }
            }
            else {
                VStack(spacing: 50) {
                    Button{
                        showQuizSetting = true
                    } label:{
                        Text("퀴즈 시작")
                    }
                    
                    Button{
                        
                    } label:{
                        Text("지난 결과")
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showQuizSetting){
            QuizSettingView()
        }
        
    }
}
#Preview {
    MainView()
}

//버튼 2개 만들기
//퀴즈 시작 버튼, 지난 결과 버튼
