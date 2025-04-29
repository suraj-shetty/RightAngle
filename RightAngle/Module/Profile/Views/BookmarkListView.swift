//
//  BookmarkListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 12/04/23.
//

import SwiftUI

struct BookmarkListView: View {
    @StateObject var viewModel = BookmarkListViewModel()
    @State private var segmentIndex: Int = 0
    private let segments = [
        SegmentItemViewModel(title: "Lessons", iconName: ""),
        SegmentItemViewModel(title: "Comments", iconName: "")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            navView()
            
            SegmentedView(selectedIndex: $segmentIndex,
                          segments: segments,
                          showText: true)
            
            content(type: self.viewModel.type)
        }
        .navigationBarBackButtonHidden()
        .background {
            Color.base.ignoresSafeArea()
        }
        .onChange(of: segmentIndex) { newValue in
            switch newValue {
            case 1: self.viewModel.type = .shots
            default: self.viewModel.type = .lessons
            }
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
            
            Text("My Bookmarks")
                .foregroundColor(.navText)
                .font(.system(size: 25,
                              weight: .medium))
            
        }
        .frame(height: 84)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder private func content(type: BookmarkListType) -> some View {
        switch type {
        case .lessons:
            List(self.viewModel.lessons) { lesson in
                BookmarkCellView(viewModel: lesson)
    //                .frame(height: 179)
                    .listRowBackground(Color.base)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 20,
                                         leading: 20,
                                         bottom: 0,
                                         trailing: 20))
            }
            .listStyle(.plain)
            
        case .shots:
            GeometryReader { proxy in
                let cellWidth = floor((proxy.size.width)/3.0) - 2.0
                let grids = Array<GridItem>(repeating: GridItem(.fixed(cellWidth),
                                                                spacing: 1),
                                            count: 3)
                
                LazyVGrid(columns: grids, spacing: 1) {
                    ForEach(0..<5, id:\.self) { _ in
                        shotCellView()
                            .frame(height: cellWidth * 1.4)
                    }
                }
            }
        }
    }
    
    private func shotCellView() -> some View {
        ZStack(alignment: .bottomLeading) {
            Color.brightGray
            
            HStack(spacing: 3) {
                Image("view")
                
                Text("11K")
                    .foregroundColor(.textWhite)
                    .font(.system(size: 10, weight: .medium))
            }
            .padding(.horizontal, 7)
            .frame(height: 17)
            .background {
                Capsule()
                    .fill(Color.black)
                    .opacity(0.6)
            }
            .padding(.leading, 15)
            .padding(.bottom, 15)
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
    }
}
