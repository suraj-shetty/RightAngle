//
//  CheckBoxView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import Foundation
import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Image(checked ? "check" : "uncheck")
//            .opacity((!checked && colorScheme == .light)
//                     ? 0.3
//                     : 1.0
//            )
            .onTapGesture {
                withAnimation {
                    self.checked.toggle()
                }
            }
    }
}


struct CheckBoxView_Previews: PreviewProvider {
    @State var checked: Bool = true
    
    static var previews: some View {
        CheckBoxView(checked: .init(get: {
            return true
        }, set: { _ in
            
        }))
        .preferredColorScheme(.dark)
    }
}
