//
//  HomeTabView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import SwiftUI

struct HomeTabView: View {
    @State private var index: Int = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            GeometryReader { proxy in
                contentView(inset: proxy.safeAreaInsets)
            }
            
            HomeTabbarView(current: $index)
        }
        
//        ZStack(alignment: .bottom) {
//            GeometryReader { proxy in
////                ReelsListView(contentInset: proxy.safeAreaInsets)
//                switch index {
//                case 0: HomeListView()
//                case 1: TeachersListView()
//                case 2: ReelsListView(contentInset: proxy.safeAreaInsets)
//                default: EmptyView()
//                }
//                VStack(alignment: .center) {
//                    Spacer()
//
//                    HomeTabbarView(current: $index)
//                }
//            }
//        }
        .background {
            Color.base
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func contentView(inset: EdgeInsets) -> some View {
        switch index {
        case 0: HomeListView()
        case 1: TeachersListView()
        case 2: ReelsListView(contentInset: EdgeInsets(top: inset.top,
                                                       leading: inset.leading,
                                                       bottom: 0,
                                                       trailing: inset.bottom))
        default: EmptyView()
        }
    }
}

struct HomeTabbarView: View {
    @Binding private var currentSegment:Int
    @State private var frames: Array<CGRect>
    
    init(current: Binding<Int>) {
        self._currentSegment = current
        self.frames = Array<CGRect>(repeating: .zero, count: 4)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 0) {
                    Button {
                        self.currentSegment = 0
                    } label: {
                        Image("homeTabIcon")
                            .opacity(currentSegment == 0 ? 1.0 : 0.5)
                    }
                    .readFrame(space: .global) { rect in
                        self.frames[0] = rect
                    }
                    
                    Spacer()
                    
                    Button {
                        self.currentSegment = 1
                    } label: {
                        Image("teacherTabIcon")
                            .opacity(currentSegment == 1 ? 1.0 : 0.5)
                    }
                    
                    .readFrame(space: .global) { rect in
                        self.frames[1] = rect
                    }
                    
                    Spacer()
                    
                    Button {
                        self.currentSegment = 2
                    } label: {
                        Image("reelsTabIcon")
                            .opacity(currentSegment == 2 ? 1.0 : 0.5)
                    }
                    
                    .readFrame(space: .global) { rect in
                        self.frames[2] = rect
                    }
                    
                    Spacer()
                    
                    Button {
                        NotificationCenter.default.post(name: .menuShow, object: nil)
//                        self.currentSegment = 3
                    } label: {
                        Image("menuTabIcon")
                            .opacity(currentSegment == 3 ? 1.0 : 0.5)
                    }
                    .readFrame(space: .global) { rect in
                        self.frames[3] = rect
                    }
                }
                
                Capsule()
                    .fill(Color.textWhite)
                    .frame(width: 12, height: 3)
                    .offset(x: frames[currentSegment].minX - frames[0].minX + frames[currentSegment].width/2.0 - 6)
                    .animation(.easeInOut, value: currentSegment)
            }
            .padding(.horizontal, 43)
            .padding(.vertical, 22)
            .background {
                Color.textBlack
                    .ignoresSafeArea(.container, edges: .bottom)
            }
        }
    }
}



struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
