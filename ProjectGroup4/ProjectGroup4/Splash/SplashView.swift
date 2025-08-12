//
//  ContentView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/11/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("3초 후에 메인 화면으로 넘어갑니다.")
                    .font(.title2)
                    .padding()
            }
            .padding()
        }
    }
}
//3초 뒤에 메인 뷰로 넘어가기
#Preview {
    SplashView()
}

