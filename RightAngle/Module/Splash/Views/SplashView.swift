//
//  SplashView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 27/01/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            
            VStack {
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    Image("curve1")
                        .offset(x: 0, y: -44)
                }
                Spacer()
                
                HStack {
                    Image("curve2")
                    
                    Spacer()
                }
            }
            
            
            VStack(alignment: .center, spacing: 16) {
                Image("logo")
                
                Text("Right Angle")
                    .foregroundColor(.textWhite)
                    .font(.system(size: 36,
                                  weight: .bold))
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
        }
        .background {
            Color.baseGrey
                .ignoresSafeArea()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
