//
//  UnderlineModifier.swift
//  StarGaze
//
//  Created by Suraj Shetty on 25/05/22.
//  Copyright © 2022 Day1Tech. All rights reserved.
//

import Foundation
import SwiftUI

struct UnderlineModifier: ViewModifier
{
    var selectedIndex: Int
    let frames: [CGRect]
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View
    {
        content
            .background(
                    Capsule()
                        .fill(Color.textBlack)
                        .frame(width: frames[selectedIndex].width, height: 2)
                        .offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .bottomLeading
            )
            .background(
                Rectangle()
                    .fill(Color.paleGrey)
//                    .opacity((colorScheme == .dark) ? 0.06 : 0.2)
                    .frame(height: 2),
                alignment: .bottomLeading)
            .animation(.default, value: selectedIndex)
    }
}
