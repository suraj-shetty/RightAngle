//
//  AccountInfoView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/04/23.
//

import SwiftUI

struct AccountInfoView: View {
    @ObservedObject var info: AccountInfoViewModel
    var body: some View {
        VStack(spacing:0) {
            Image(info.avatar)
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Capsule())
            
            Text(info.title)
                .foregroundColor(.textBlack)
                .font(.system(size: 16, weight: .medium))
                .frame(height: 23)
                .padding(.top, 8)
            
            Text(info.subTitle)
                .foregroundColor(.textBlack)
                .opacity(0.5)
                .font(.system(size: 12, weight: .medium))
                .frame(height: 23)
                .padding(.top, -5)
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal)
//        .background {
//            ZStack {
//                RoundedRectangle(cornerRadius: 14)
//                    .fill(Color.accountCardBg)
//                
//                RoundedRectangle(cornerRadius: 14)
//                    .stroke(Color.accountCardBorder,
//                            lineWidth: 2)
//            }
//            .scaledToFill()
//        }
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AccountInfoView(info: .init(info: .init(name: "Allen Camber",
                                                    grade: "GRADE 6",
                                                    board: "ISCE",
                                                    avatar: "avatar1")))
        }
    }
}
