//
//  CategorySelectionView.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import SwiftUI

struct QuizSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedCategory: QuizData.Category
    @Binding var selectedDifficulty: QuizData.Difficulty
    @Binding var toQuizSectionView : Bool
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("퀴즈 설정")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
             
                VStack(alignment: .leading, spacing: 15) {
                    Text("카테고리 선택")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12) {
                        ForEach(QuizData.Category.allCases, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                HStack {
                                    Text(category.name)
                                        .font(.body)
                                        .foregroundColor(selectedCategory == category ? .white : .primary)
                                    Spacer()
                                    if selectedCategory == category {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedCategory == category ? Color.blue : Color.gray.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedCategory == category ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal)
                
               
                VStack(alignment: .leading, spacing: 15) {
                    Text("난이도 선택")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12) {
                        ForEach(QuizData.Difficulty.allCases, id: \.self) { difficulty in
                            Button(action: {
                                selectedDifficulty = difficulty
                            }) {
                                HStack {
                                    Text(difficulty.name)
                                        .font(.body)
                                        .foregroundColor(selectedDifficulty == difficulty ? .white : .primary)
                                    Spacer()
                                    if selectedDifficulty == difficulty {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedDifficulty == difficulty ? Color.green : Color.gray.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedDifficulty == difficulty ? Color.green : Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
               
                Button(action: {
                    toQuizSectionView = true
                    dismiss()
                    
                    print("선택된 카테고리: \(selectedCategory.name)")
                    print("선택된 난이도: \(selectedDifficulty.name)")
                }) {
                    Text("퀴즈 시작")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.orange)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    QuizSettingView(selectedCategory:.constant(QuizData.Category.animals) , selectedDifficulty: .constant(QuizData.Difficulty.easy),toQuizSectionView: .constant(false))
}
