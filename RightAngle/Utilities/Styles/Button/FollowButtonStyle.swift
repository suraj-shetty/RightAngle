//
//  FollowButtonStyle.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 03/08/23.
//

import Foundation
import SwiftUI

struct FollowButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.textWhite)
            .font(.system(size: 16,
                          weight: .semibold))
            .frame(height: 48)
            .padding(.horizontal, 50)
//            .frame(maxWidth: .infinity)
            .background {
                Capsule()
                    .fill(
                        Color.submit
                            .opacity(isEnabled ? 1.0 : 0.4)
                    )
            }
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

extension Button {
    func followButtonStyle() -> some View {
        buttonStyle(FollowButtonStyle())
    }
}
