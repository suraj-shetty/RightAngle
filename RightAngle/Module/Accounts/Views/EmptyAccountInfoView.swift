//
//  EmptyAccountInfoView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/04/23.
//

import SwiftUI

struct EmptyAccountInfoView: View {
    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Capsule()
                    .fill(Color.white)
                
                Image("add")
            }
            .frame(width: 75, height: 75)
            
            Text("Add child")
                .foregroundColor(.textBlack)
                .font(.system(size: 16, weight: .medium))
                .frame(height: 23)
                .padding(.top, 5)
        }
        .padding(.vertical, 16)
        .padding(.horizontal)        
    }
}

struct EmptyAccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyAccountInfoView()
    }
}
