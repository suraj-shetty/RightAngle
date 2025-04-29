//
//  PurchaseListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 12/04/23.
//

import SwiftUI

struct PurchaseListView: View {
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
            Color.base.ignoresSafeArea()
        }
    }
    
    private func navView() -> some View {
        ZStack {
            HStack {
                Button {
                    NotificationCenter.default.post(name: .menuShow,
                                                    object: nil)
                } label: {
                    Image("navBack")
                }
                
                Spacer()
            }
            
            Text("My Purchases")
                .foregroundColor(.navText)
                .font(.system(size: 25,
                              weight: .medium))
            
        }
        .frame(height: 84)
        .padding(.horizontal, 20)
    }
    
    private func cellView(for viewModel: FeedViewModel, proxy:GeometryProxy) -> some View {
        FeedCellView(viewModel: viewModel)
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.base)
            .frame(width: proxy.size.width)
    }
}

struct PurchaseListView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseListView()
    }
}
