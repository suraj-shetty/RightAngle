//
//  NavBackButton.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 29/01/23.
//

import SwiftUI

struct NavBackButton: View {
    let dismiss: DismissAction
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image("navBack")
        }

    }
}

//struct NavBackButton_Previews: PreviewProvider {
//    static var previews: some View {
//        NavBackButton()
//    }
//}
