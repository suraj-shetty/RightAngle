//
//  BookmarkCellView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import SwiftUI

struct BookmarkCellView: View {
    @StateObject var viewModel: BookmarkViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(viewModel.title)
                .foregroundColor(.textBlack)
                .font(.system(size: 22, weight: .medium))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            HStack {
                Text(viewModel.subTitle)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 12, weight: .medium))
                    .opacity(0.5)
                
                Spacer()
                
                Text("\(Int(viewModel.progress * 100))%")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 12, weight: .semibold))
                    .opacity(0.5)
            }
            
            ProgressView(value: viewModel.progress)
                .progressViewStyle(.linear)
                .tint(.textBlack.opacity(0.2))
                .background {
                    Color.white2
                }
            
            HStack(spacing: 3) {
                Image("person")
                
                Text(viewModel.author)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14, weight: .medium))
                    .frame(height: 23)
            }
            .padding(.init(top: 1, leading: 11, bottom: 1, trailing: 12))
            .background {
                Capsule()
                    .fill(Color.white.opacity(0.7))
            }
            .padding(.top, 7)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 26)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.paleYellow)
        }
    }
}

struct BookmarkCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                BookmarkCellView(viewModel: .init(title: "Measurement, data and geometry",
                                                  subTitle: "Math, Chapter 5",
                                                  author: "Manish Malhotra",
                                                  progress: 0.67))
                    .frame(width: 284)
                Spacer()
            }
            
            Spacer()
        }
    }
}
