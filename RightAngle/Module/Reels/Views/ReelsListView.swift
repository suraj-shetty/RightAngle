//
//  ReelsListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/03/23.
//

import SwiftUI

struct ReelsListView: View {
    var contentInset: EdgeInsets = .init()
    @StateObject private var viewModel = ReelsListViewModel()
    var body: some View {
        
//        VTabView {
//            ForEach(0..<viewModel.reels.count, id: \.self) { index in
//                ReelsPageView(viewModel: viewModel.reels[index])
//            }
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//        .ignoresSafeArea()
//        .ignoresSafeArea(.all, edges: .vertical)
        GeometryReader { proxy in
//            let screen = proxy.frame(in: .global)
//
////            ScrollView(.init()) {
////                TabView {
////                    ForEach(0..<viewModel.reels.count, id: \.self) { index in
////                        ReelsPageView(viewModel: viewModel.reels[index])
////                            .modifier(VerticalTabBarModifier(screen: screen))
////                    }
////                }
////                .tabViewStyle(.page(indexDisplayMode: .never))
////                .rotationEffect(.init(degrees: 90))
////                .frame(width: screen.width)
////            }
//
            TabView {
                ForEach(0..<viewModel.reels.count, id: \.self) { index in
                    ReelsPageView(viewModel: viewModel.reels[index], contentInset: contentInset)
                }
                .rotationEffect(.init(degrees: -90))
                .frame(width: proxy.size.width,
                       height: proxy.size.height)
                .offset(y: -13)
            }
            .frame(width: proxy.size.height,
                   height: proxy.size.width)
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width, y: 0)
            .tabViewStyle(.page(indexDisplayMode: .never))
//            .frame(width: screen.height, height: screen.width)
//            .rotationEffect(.init(degrees: 90))
//            .frame(width: screen.width)
//            .offset(x: proxy.size.width)
//            .background {
//                Color.blue
//            }
////            .frame(width: screen.height, height: screen.width)
//            .ignoresSafeArea()
        }
        .onAppear(perform: {
            print(contentInset)
        })
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReelsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsListView(contentInset: .init())
    }
}
