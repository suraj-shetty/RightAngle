//
//  WatchHistoryView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 11/04/23.
//

import SwiftUI

struct WatchHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            navView()
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
    }
    
    private func cellView(for viewModel: FeedViewModel, proxy:GeometryProxy) -> some View {
        FeedCellView(viewModel: viewModel)
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.base)
            .frame(width: proxy.size.width)
    }
    
    private func navView() -> some View {
        ZStack {
            HStack {
                NavBackButton(dismiss: self.dismiss)
                
                Spacer()
            }
            
            Text("My Watch History")
                .foregroundColor(.navText)
                .font(.system(size: 25,
                              weight: .medium))
            
        }
        .frame(height: 84)
        .padding(.horizontal, 20)
    }
}

struct WatchHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchHistoryView()
        }
    }
}
