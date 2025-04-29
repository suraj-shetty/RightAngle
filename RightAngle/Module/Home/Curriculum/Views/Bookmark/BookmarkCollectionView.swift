//
//  BookmarkListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import SwiftUI

struct BookmarkCollectionView: View {
    
    private let bookmarks: [BookmarkViewModel] = [
        .init(title: "Measurement, data and geometry",
              subTitle: "Math, Chapter 5",
              author: "Manish Malhotra",
              progress: 0.67),
        .init(title: "Measurement, data and geometry 2",
              subTitle: "Math, Chapter 6",
              author: "Manish Malhotra",
              progress: 0.57)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Bookmarked videos")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 19, weight: .medium))
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            let row = GridItem(.fixed(284),
                               spacing: 15, alignment: .center)
            ScrollView(.horizontal) {
                LazyHGrid(rows: [row]) {
                    ForEach(bookmarks) { bookmark in
                        BookmarkCellView(viewModel: bookmark)
                            .frame(width: 284)
                    }
                }
                .frame(height: 178)
                .padding(.horizontal, 20)
            }
        }
        
    }
}

struct BookmarkCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            BookmarkCollectionView()
            
            Spacer()
        }
    }
}
