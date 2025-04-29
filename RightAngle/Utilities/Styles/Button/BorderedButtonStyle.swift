//
//  BorderedButtonStyle.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/01/23.
//

import Foundation
import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.textBlack)
            .font(.system(size: 18,
                          weight: .semibold))
            .padding(.horizontal, 32)
            .frame(height: 70)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.strokeBorder,
                            lineWidth: 1)
            }
    }
    
}
