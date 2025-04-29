//
//  SubmitButtonStyle.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/01/23.
//

import Foundation
import SwiftUI

struct SubmitButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.textWhite)
            .font(.system(size: 18,
                          weight: .semibold))
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        Color.submit
                            .opacity(isEnabled ? 1.0 : 0.4)
                    )
            }
            .opacity(configuration.isPressed ? 0.6 : 1.0)
//            .opacity(isEnabled ? 1.0 : 0.4)
    }
    
}
