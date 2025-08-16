//
//  HistoryList.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/13/25.
//
import SwiftUI


// MARK: View
struct HistoryList: View {
    let suite: ResultSuite
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 그라데이션 배경
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
                
                // 배경 장식 원들
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 160, height: 160)
                    .offset(x: -70, y: -120)
                
                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 100, height: 100)
                    .offset(x: 90, y: 180)
                
                VStack(spacing: 25) {
                    // 헤더
                    VStack(spacing: 15) {
                        Text("📝")
                            .font(.system(size: 50))
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        Text("상세 결과")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        
                        // 퀴즈 정보
                        HStack(spacing: 20) {
                            VStack {
                                Text(suite.category.quiz.name)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("카테고리")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 1, height: 30)
                            
                            VStack {
                                Text(suite.category.level.name)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("난이도")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.15))
                                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        )
                    }
                    .padding(.top, 20)
                    
                    // 결과 리스트
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(suite.results) { result in
                                ResultItemView(result: result)
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
