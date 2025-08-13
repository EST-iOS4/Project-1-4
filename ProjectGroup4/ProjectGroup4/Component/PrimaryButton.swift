//
//  PrimaryButton.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/13/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 0.2, green: 0.8, blue: 0.4))
                    )
            }
            .buttonStyle(PlainButtonStyle())
    }
}

// 프리뷰
#Preview {
   //예시
        PrimaryButton(title: "텍스트") {
            print("버튼 눌림")
        }
    
  
}
