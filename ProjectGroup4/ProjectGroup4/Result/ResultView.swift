import SwiftUI
import SwiftData

// MARK: View
struct ResultView: View {
    // MARK: state
    @Environment(\.modelContext) private var modelContext
    @State private var isSaved = false
    
    let category: QuizData.Category
    let difficulty: QuizData.Difficulty
    var results: [QuizResult]
    
    @Binding var toQuizSectionView: Bool
    @Binding var saveSuccessToastMessage: Bool
    
    var correctCount: Int {
        self.results
            .filter { $0.isCorrect == true }
            .count
    }
    
    var scorePercentage: Double {
        guard results.count > 0 else { return 0.0 }
        return Double(correctCount) / Double(results.count) * 100
    }
    
    // MARK: body
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
                    .frame(width: 180, height: 180)
                    .offset(x: -80, y: -150)
                
                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 120, height: 120)
                    .offset(x: 100, y: 200)
                
                VStack(spacing: 0) {
                 
                    VStack(spacing: 20) {
                      
                        
                        Text("퀴즈 완료!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        
                        Text("결과를 확인해보세요")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 30)
                    
                  
                    CorrectCountLabel
                        .padding(.vertical, 25)
                    
                
                    ResultItemList
                    

                    SaveButton
                        .padding(.vertical)
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print(category)
            print(difficulty)
        }
    }
    
    private func saveResult() {
        
    }
}

// MARK: Component
extension ResultView {
    var CorrectCountLabel: some View {
        VStack(spacing: 15) {
        
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: scorePercentage / 100)
                    .stroke(
                        scorePercentage >= 80 ? Color.green : (scorePercentage >= 60 ? Color.orange : Color.red),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: scorePercentage)
                
                VStack(spacing: 5) {
                    Text("\(correctCount)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("/ \(results.count)")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            
          
            VStack(spacing: 8) {
                HStack(spacing: 15) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.green)
                    
                    Text("정답률: \(Int(scorePercentage))%")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white.opacity(0.15))
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                
                Text(getScoreMessage())
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 25)
    }
    
    var ResultItemList: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "list.bullet.clipboard.fill")
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text("상세 결과")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 25)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(results) { result in
                        ResultItemView(result: result)
                    }
                }
                .padding(.horizontal, 25)
            }
            .frame(maxHeight: 300)
        }
    }
    
    var SaveButton: some View {
        Button {
            print("SwiftData로 저장")
            
            let newSuite = ResultSuite(results: results,
                                     created: Date(),
                                     category: .init(
                                        quiz: category, level: difficulty)
            )
            modelContext.insert(newSuite)
            isSaved = true
            
            toQuizSectionView = false
            saveSuccessToastMessage = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                saveSuccessToastMessage = false
            }
            
            print("새로운 ResultSuite가 저장되었습니다. ID: \(newSuite.id)")
        } label: {
            HStack(spacing: 15) {
                Image(systemName: isSaved ? "checkmark.circle.fill" : "square.and.arrow.down.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                
                Text(isSaved ? "결과가 저장되었습니다" : "저장하기")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                if !isSaved {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 25)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                isSaved ? Color.gray.opacity(0.7) : Color.green.opacity(0.9),
                                isSaved ? Color.gray.opacity(0.6) : Color.teal.opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: isSaved ? .gray.opacity(0.2) : .green.opacity(0.4),
                           radius: 15, x: 0, y: 8)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
        .disabled(isSaved)
        .padding(.horizontal, 25)
        .scaleEffect(isSaved ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSaved)
    }
    
    private func getScoreMessage() -> String {
        let percentage = scorePercentage
        if percentage >= 90 {
            return "완벽해요! 🌟"
        } else if percentage >= 80 {
            return "훌륭해요! 👏"
        } else if percentage >= 60 {
            return "좋아요! 💪"
        } else {
            return "다시 도전해보세요! 🔥"
        }
    }
}

// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ResultSuite.self, configurations: config)
    
    ResultView(category: .animals, difficulty: .easy, results: [
        QuizResult(image: "사자", answer: "사자", correctAnswer: "사자", isCorrect: true),
        QuizResult(image: "호랑이", answer: "여우", correctAnswer: "호랑이", isCorrect: false)
    ], toQuizSectionView: .constant(true), saveSuccessToastMessage: .constant(false))
        .modelContainer(container)
}
