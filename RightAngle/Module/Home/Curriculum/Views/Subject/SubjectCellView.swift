//
//  SubjectCellView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/02/23.
//

import SwiftUI

struct SubjectCellView: View {
    @ObservedObject var viewModel: SubjectViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Image(viewModel.icon)
                
                Spacer()
                
                Text(viewModel.title)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16, weight: .medium))
                    .frame(height: 23)
                
                Text("\(viewModel.count) Videos")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .medium))
                    .frame(height: 23)
                    .opacity(0.5)
                    .padding(.top, -3)
            }
            
            Spacer()
        }
        .padding(.init(top: 21,
                       leading: 19,
                       bottom: 13,
                       trailing: 19))
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.paleGreen)
        }
    }
}

struct SubjectCellView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectCellView(viewModel: .init(title: "Maths",
                                         count: 24,
                                         icon: "math"))
        .frame(width: 156, height: 193)
    }
}
