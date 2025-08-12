//
//  ToastMessage.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/12/25.
//

import SwiftUI



struct ToastMessage: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.6))
            )
            .shadow(radius: 5)
            .padding(.horizontal, 20)
    }
}


#Preview {
    ToastMessage(message: "메시지 입력")
}
