//
//  FeedCellView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/03/23.
//

import SwiftUI

struct FeedCellView: View {
    @ObservedObject var viewModel: FeedViewModel
    var body: some View {
        VStack(spacing: 0) {
            Image(viewModel.icon)
                .resizable()
                .scaledToFill()
                .aspectRatio(3, contentMode: .fit)
                .clipShape(Rectangle())
                .background {
                    Color.paleGrey
                }
            
            HStack(spacing: 7) {
                Image("Ellipse 2")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.title)
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .medium))
                        .frame(height: 23)
                    
                    HStack(alignment: .center, spacing: 5) {
                        Text(viewModel.authorName)
                            .foregroundColor(.paleGrey3)
                            .font(.system(size: 12, weight: .medium))
                        
                        Capsule()
                            .fill(Color.paleGrey3)
                            .frame(width: 2, height: 2)
                        
                        Text("views.count".countString(value: viewModel.viewCount))
                            .foregroundColor(.paleGrey3)
                            .font(.system(size: 12, weight: .medium))
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("moreOption")
                }
                .frame(width: 46)                
            }
            .padding(.init(top: 13,
                           leading: 20,
                           bottom: 25,
                           trailing: 0))
        }
    }
}

struct FeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            FeedCellView(viewModel: .init(icon:"feed1",
                                          title: "How animal see colours?",
                                          author: "Kuldeep Mehta",
                                          count: 3700))
            
            Spacer()
        }
    }
}
