//
//  HistoryRow.swift
//  ProjectGroup4
//
//  Created by 김민우 on 8/13/25.
//
import SwiftUI
import SwiftData


// MARK: View
struct HistoryRow: View {
    let suite: ResultSuite
    
    private var correctCount: Int {
        suite.results.filter { $0.isCorrect }.count
    }
    
    private var scorePercentage: Double {
        guard suite.results.count > 0 else { return 0.0 }
        return Double(correctCount) / Double(suite.results.count) * 100
    }
    
    var body: some View {
        HStack(spacing: 20) {
            
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 4)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: scorePercentage / 100)
                    .stroke(
                        scorePercentage >= 80 ? Color.green : (scorePercentage >= 60 ? Color.orange : Color.red),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(scorePercentage))%")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            
          
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Image(systemName: getCategoryIcon(suite.category.quiz))
                        .font(.body)
                        .foregroundColor(.blue.opacity(0.8))
                    
                    Text(suite.category.quiz.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 10) {
                    Image(systemName: getDifficultyIcon(suite.category.level))
                        .font(.body)
                        .foregroundColor(.green.opacity(0.8))
                    
                    Text(suite.category.level.name)
                        .font(.subheadline)
                        .foregroundColor(.primary.opacity(0.8))
                }
                
                HStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.body)
                        .foregroundColor(.purple.opacity(0.8))
                    
                    Text("\(correctCount) / \(suite.results.count)")
                        .font(.subheadline)
                        .foregroundColor(.primary.opacity(0.8))
                }
            }
            
            Spacer()
            
         
            VStack(alignment: .trailing, spacing: 8) {
                Text(suite.created, style: .date)
                    .font(.caption)
                    .foregroundColor(.primary.opacity(0.6))
                
                Text(suite.created, style: .time)
                    .font(.caption)
                    .foregroundColor(.primary.opacity(0.6))
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.primary.opacity(0.4))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
        )
    }
    
    private func getCategoryIcon(_ category: QuizData.Category) -> String {
        switch category {
        case .animals:
            return "pawprint.fill"
        default:
            return "book.fill"
        }
    }
    
    private func getDifficultyIcon(_ difficulty: QuizData.Difficulty) -> String {
        switch difficulty {
        case .easy:
            return "1.circle.fill"
        default:
            return "star.fill"
        }
    }
}
