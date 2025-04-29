//
//  InputContentModifier.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 29/01/23.
//

import SwiftUI

struct InputContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack(spacing: 0, content: {
            content
            Spacer()
        })
            .padding(.horizontal, 39)
            .padding(.vertical, 24)
            .background {
                Capsule()
                    .stroke(Color.strokeBorder,
                            lineWidth: 1)
            }
    }
}

extension View {
    func inputFieldStyle() -> some View {
        modifier(InputContentModifier())
    }
    
    func inputField(with title: String) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(title)
                .foregroundColor(.textBlack)
                .font(.system(size: 14, weight: .semibold))
                .frame(height: 22)
            
            modifier(InputContentModifier())
        }
    }
}

