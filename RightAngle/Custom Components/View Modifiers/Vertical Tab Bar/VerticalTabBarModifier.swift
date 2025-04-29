//
//  VerticalTabBarModifier.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/03/23.
//

import Foundation
import SwiftUI

struct VerticalTabBarModifier: ViewModifier {
    var screen: CGRect
    
    func body(content: Content) -> some View {
        return content
            .frame(width: screen.width, height: screen.height)
            .rotationEffect(.init(degrees: -90))
            .frame(width: screen.height, height: screen.width)
    }
}
