import SwiftUI

struct QuizSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedCategory: QuizData.Category
    @Binding var selectedDifficulty: QuizData.Difficulty
    @Binding var toQuizSectionView : Bool
    
    var body: some View {
        NavigationView {
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
                        .frame(width: 180, height: 180)
                        .offset(x: -80, y: -150)
                    
                    Circle()
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 120, height: 120)
                        .offset(x: 100, y: 200)
                    
                    ScrollView {
                        VStack(spacing: 35) {
                            // 헤더 섹션
                            VStack(spacing: 15) {
                                
                                Text("퀴즈 시작")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                
                                Text("원하는 설정을 선택하세요")
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.top, 30)
                            
                           
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "folder.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                    Text("카테고리 선택")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 25)
                                
                                VStack(spacing: 12) {
                                    ForEach(QuizData.Category.allCases, id: \.self) { category in
                                        Button(action: {
                                            selectedCategory = category
                                        }) {
                                            HStack(spacing: 15) {
                                                // 카테고리별 아이콘 (예시)
                                                Image(systemName: getCategoryIcon(category))
                                                    .font(.title3)
                                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                                
                                                Text(category.name)
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                                
                                                Spacer()
                                                
                                                if selectedCategory == category {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.title3)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.vertical, 18)
                                            .padding(.horizontal, 20)
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(selectedCategory == category
                                                          ? LinearGradient(
                                                                gradient: Gradient(colors: [
                                                                    Color.blue.opacity(0.9),
                                                                    Color.indigo.opacity(0.8)
                                                                ]),
                                                                startPoint: .leading,
                                                                endPoint: .trailing
                                                            )
                                                          : LinearGradient(
                                                                gradient: Gradient(colors: [
                                                                    Color.white.opacity(0.15),
                                                                    Color.white.opacity(0.1)
                                                                ]),
                                                                startPoint: .leading,
                                                                endPoint: .trailing
                                                            )
                                                    )
                                                    .shadow(color: selectedCategory == category
                                                           ? .blue.opacity(0.3)
                                                           : .black.opacity(0.1),
                                                           radius: selectedCategory == category ? 8 : 4,
                                                           x: 0, y: 4)
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.white.opacity(selectedCategory == category ? 0.3 : 0.2), lineWidth: 1)
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .scaleEffect(selectedCategory == category ? 1.02 : 1.0)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedCategory)
                                    }
                                }
                                .padding(.horizontal, 25)
                            }
                            
                            // 난이도 선택 섹션
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "chart.bar.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                    Text("난이도 선택")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 25)
                                
                                VStack(spacing: 12) {
                                    ForEach(QuizData.Difficulty.allCases, id: \.self) { difficulty in
                                        Button(action: {
                                            selectedDifficulty = difficulty
                                        }) {
                                            HStack(spacing: 15) {
                                                // 난이도별 아이콘
                                                Image(systemName: getDifficultyIcon(difficulty))
                                                    .font(.title3)
                                                    .foregroundColor(selectedDifficulty == difficulty ? .white : .primary)
                                                
                                                Text(difficulty.name)
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(selectedDifficulty == difficulty ? .white : .primary)
                                                
                                                Spacer()
                                                
                                                if selectedDifficulty == difficulty {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .font(.title3)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.vertical, 18)
                                            .padding(.horizontal, 20)
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(selectedDifficulty == difficulty
                                                          ? LinearGradient(
                                                                gradient: Gradient(colors: [
                                                                    Color.green.opacity(0.9),
                                                                    Color.teal.opacity(0.8)
                                                                ]),
                                                                startPoint: .leading,
                                                                endPoint: .trailing
                                                            )
                                                          : LinearGradient(
                                                                gradient: Gradient(colors: [
                                                                    Color.white.opacity(0.15),
                                                                    Color.white.opacity(0.1)
                                                                ]),
                                                                startPoint: .leading,
                                                                endPoint: .trailing
                                                            )
                                                    )
                                                    .shadow(color: selectedDifficulty == difficulty
                                                           ? .green.opacity(0.3)
                                                           : .black.opacity(0.1),
                                                           radius: selectedDifficulty == difficulty ? 8 : 4,
                                                           x: 0, y: 4)
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.white.opacity(selectedDifficulty == difficulty ? 0.3 : 0.2), lineWidth: 1)
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .scaleEffect(selectedDifficulty == difficulty ? 1.02 : 1.0)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedDifficulty)
                                    }
                                }
                                .padding(.horizontal, 25)
                            }
                            
                            // 시작 버튼
                            Button(action: {
                                toQuizSectionView = true
                                dismiss()
                                
                                print("선택된 카테고리: \(selectedCategory.name)")
                                print("선택된 난이도: \(selectedDifficulty.name)")
                            }) {
                                HStack(spacing: 15) {
                                    Image(systemName: "play.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                    Text("퀴즈 시작")
                                        .font(.title2)
                                        .fontWeight(.bold)
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
                                                    Color.orange.opacity(0.9),
                                                    Color.red.opacity(0.8)
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .shadow(color: .orange.opacity(0.5), radius: 15, x: 0, y: 8)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                            .padding(.horizontal, 25)
                            .padding(.bottom, 30)
                            .scaleEffect(1.0)
                        }
                    }
                }
            }
        }
    }
    
    // 카테고리별 아이콘 반환 함수
    private func getCategoryIcon(_ category: QuizData.Category) -> String {
        // QuizData.Category의 실제 케이스에 따라 적절한 아이콘 반환
        // 예시로 기본 아이콘들을 사용
        switch category {
        case .animals:
            return "pawprint.fill"
        default:
            return "book.fill"
        }
    }
    
    // 난이도별 아이콘 반환 함수
    private func getDifficultyIcon(_ difficulty: QuizData.Difficulty) -> String {
        switch difficulty {
        case .easy:
            return "1.circle.fill"
        case .medium:
            return "2.circle.fill"
        default:
            return "3.circle.fill"
        }
    }
}

#Preview {
    QuizSettingView(selectedCategory: .constant(QuizData.Category.animals), selectedDifficulty: .constant(QuizData.Difficulty.easy), toQuizSectionView: .constant(false))
}
