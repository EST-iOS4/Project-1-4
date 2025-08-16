//
//  QuizHistoryView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//
import SwiftUI
import SwiftData


// MARK: View
struct QuizHistoryView: View {
   
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ResultSuite.created, order: .reverse) private var resultSuites: [ResultSuite]
    
    // MARK: body
    var body: some View {
        NavigationStack {
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
                        .frame(width: 180, height: 180)
                        .offset(x: -80, y: -150)
                    
                    Circle()
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 120, height: 120)
                        .offset(x: 100, y: 200)
                    
                    VStack(spacing: 0) {
                      
                        VStack(spacing: 15) {
                            Text("📊")
                                .font(.system(size: 60))
                                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                            
                            Text("퀴즈 기록")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            Text("지난 퀴즈 결과를 확인하세요")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        
                      
                        if resultSuites.isEmpty {
                         
                            VStack(spacing: 25) {
                                Spacer()
                                
                                VStack(spacing: 20) {
                                    Image(systemName: "doc.text.magnifyingglass")
                                        .font(.system(size: 80))
                                        .foregroundColor(.white.opacity(0.6))
                                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                                    
                                    Text("저장된 결과가 없습니다")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("퀴즈를 완료하고 결과를 저장해보세요!")
                                        .font(.body)
                                        .foregroundColor(.white.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.horizontal, 40)
                                
                                Spacer()
                            }
                        } else {
                           
                            ScrollView {
                                LazyVStack(spacing: 15) {
                                    ForEach(resultSuites) { suite in
                                        NavigationLink {
                                            HistoryList(suite: suite)
                                        } label: {
                                            HistoryRow(suite: suite)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal, 25)
                                .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
          
        }
    }
    
    private func deleteResult(at offsets: IndexSet) {
        for offset in offsets {
            let suite = resultSuites[offset]
            modelContext.delete(suite)
        }
    }
}
// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ResultSuite.self, configurations: config)
    
    let sampleSuite1 = ResultSuite(
        results: [
            QuizResult(image: "사자", answer: "사자", correctAnswer: "사자", isCorrect: true),
            QuizResult(image: "호랑이", answer: "여우", correctAnswer: "호랑이", isCorrect: false)
        ],
        created: .now,
        category: .init(quiz: .animals, level: .easy)
    )
    
    let sampleSuite2 = ResultSuite(
        results: [
            QuizResult(image: "구글", answer: "구글", correctAnswer: "구글", isCorrect: true),
            QuizResult(image: "애플", answer: "삼성", correctAnswer: "플", isCorrect: false)
        ],
        created: .now.addingTimeInterval(-86400),
        category: .init(quiz: .brands, level: .hard)
    )
    
    container.mainContext.insert(sampleSuite1)
    container.mainContext.insert(sampleSuite2)
    
    return QuizHistoryView()
        .modelContainer(container)
}
