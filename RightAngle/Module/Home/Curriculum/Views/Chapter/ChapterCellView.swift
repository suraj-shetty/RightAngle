//
//  ChapterCellView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/02/23.
//

import SwiftUI

struct ChapterCellView: View {
    @ObservedObject var viewModel: ChapterViewModel
    var color: Color = .white
    
    var body: some View {
        HStack(alignment: .center,
               spacing: 17) {
            ZStack(alignment: .topLeading) {
                Capsule()
                    .fill(color)
                
                Text("\(viewModel.index)")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 25,
                                  weight: .light))
                    .frame(height: 23)
                    .padding(.leading, 15)
                    .padding(.top, 8)
            }
            .frame(width: 29, height: 29)
            
            Text(viewModel.title)
                .foregroundColor(.textBlack)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
            
            Image("disclosure")
        }
               .padding(.init(top: 20,
                              leading: 22,
                              bottom: 24,
                              trailing: 22))
               .background {
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color.paleGrey2,
                               lineWidth: 1)
               }
    }
}

struct ChapterCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterCellView(viewModel: .init(title: "Plants", index: 1),
                        color: .paleGreen)
    }
}
