import SwiftUI

struct MainView: View {
    @State private var showQuizSetting: Bool = false
    @State var toQuizSectionView : Bool = false
    @State var toQuizHistoryView : Bool = false
    @State var category : QuizData.Category = .animals
    @State var difficulty : QuizData.Difficulty = .easy
    @State var saveSuccessToastMessage : Bool = false
    
    var body: some View {
        NavigationStack {
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
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 200, height: 200)
                        .offset(x: -100, y: -200)
                    
                    Circle()
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 150, height: 150)
                        .offset(x: 120, y: 250)
                    
                    VStack(spacing: 0) {
                        // 헤더 섹션
                        VStack(spacing: 20) {
                          
                            Text("퀴즈 마스터")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            Text("카테고리별 퀴즈에 도전하세요!")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 100)
                        
                        Spacer()
                        
                        // 버튼 섹션
                        VStack(spacing: 25) {
                            // 퀴즈 시작 버튼
                            Button(action: {
                                showQuizSetting = true
                            }) {
                                HStack(spacing: 15) {
                                    Image(systemName: "brain.head.profile")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                    Text("퀴즈 시작")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .padding(.vertical, 20)
                                .padding(.horizontal, 25)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.green.opacity(0.9),
                                                    Color.teal.opacity(0.8)
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .shadow(color: .green.opacity(0.4), radius: 15, x: 0, y: 8)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                            .scaleEffect(1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showQuizSetting)
                            
                            // 지난 결과 버튼
                            Button(action: {
                                toQuizHistoryView = true
                            }) {
                                HStack(spacing: 15) {
                                    Image(systemName: "chart.bar.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                    Text("지난 결과")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .padding(.vertical, 20)
                                .padding(.horizontal, 25)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.indigo.opacity(0.9),
                                                    Color.purple.opacity(0.8)
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .shadow(color: .indigo.opacity(0.4), radius: 15, x: 0, y: 8)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                            .scaleEffect(1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: toQuizHistoryView)
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                        
                 
                     
                    }
                    
                    // 토스트 메시지
                    if saveSuccessToastMessage {
                        VStack {
                            Spacer()
                            
                            HStack(spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title3)
                                
                                Text("저장 완료되었습니다")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.ultraThinMaterial)
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                            )
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: saveSuccessToastMessage)
                            
                            Spacer().frame(height: 100)
                        }
                    }
                }
            }
            .sheet(isPresented: $showQuizSetting) {
                QuizSettingView(selectedCategory: $category, selectedDifficulty: $difficulty, toQuizSectionView: $toQuizSectionView)
            }
            .navigationDestination(isPresented: $toQuizSectionView, destination: {
                QuizSectionView(category: category, difficulty: difficulty, toQuizSectionView: $toQuizSectionView, saveSuccessToastMessage: $saveSuccessToastMessage)
            })
            .navigationDestination(isPresented: $toQuizHistoryView, destination: {
                QuizHistoryView()
            })
            .onChange(of: toQuizSectionView) {
                print(toQuizSectionView)
            }
        }
    }
}

#Preview {
    MainView()
}
