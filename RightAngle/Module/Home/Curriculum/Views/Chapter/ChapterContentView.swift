//
//  ChapterContentView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 07/03/23.
//

import SwiftUI

struct ChapterContentView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 20) {
            navView()
                .padding(20)
                .padding(.bottom, -20) //To remove the additional spacing
            
            VStack(alignment: .leading, spacing: 11) {
                HStack {
                    Text("SORT BY")
                        .foregroundColor(.grey1)
                        .font(.system(size: 12, weight: .medium))
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                ScrollView(.horizontal,
                           showsIndicators: false) {
                    LazyHStack(alignment: .center,
                               spacing: 5) {
                        sortOptionView(with: "Popular")
                        sortOptionView(with: "Highest Views")
                        sortOptionView(with: "Highest Stars")
                        sortOptionView(with: "Date Added")
                    }
                               .padding(.horizontal, 20)
                }
            }
            .frame(height: 69)
            
            
            GeometryReader { proxy in
                List {
                    cellView(for: .init(icon: "feed1", title: "How animal see colours?", author: "Karan Singh", count: 3700),
                    proxy: proxy)
                        
                    cellView(for: .init(icon: "feed2", title: "How animal see colours?", author: "Kuldeep Mehta", count: 3700),
                    proxy: proxy)
                    
                    cellView(for: .init(icon: "feed3", title: "How animal see colours?", author: "Monica Sharma", count: 3700),
                    proxy: proxy)
                }
                .listStyle(.plain)
            }
        }
        .background {
            Color.base
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)        
    }
    
    private func navView() -> some View {
        HStack(alignment: .top) {
            Button {
                dismiss()
            } label: {
                Image("navBack")
            }
            
            Spacer()
            
            VStack(spacing: -2) {
                Text("Chapter 3")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 25,
                                  weight: .medium))
                    .frame(height: 30)
                
                Text("Science")
                    .foregroundColor(.grey1)
                    .font(.system(size: 12,
                                  weight: .medium))
                    .frame(height: 23)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image("filter")
            }
        }
    }
    
    private func sortOptionView(with title:String) -> some View {
        ZStack {
            Text(title)
                .foregroundColor(.textBlack)
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
        }
        .background {
            Capsule()
                .fill(Color.paleBlue)
        }
        
    }
    
    private func cellView(for viewModel: FeedViewModel, proxy:GeometryProxy) -> some View {
        FeedCellView(viewModel: viewModel)
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.base)
            .frame(width: proxy.size.width)
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView()
    }
}
