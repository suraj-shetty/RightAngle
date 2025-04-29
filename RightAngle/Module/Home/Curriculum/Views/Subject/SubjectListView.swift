//
//  SubjectListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/02/23.
//

import SwiftUI

struct SubjectListView: View {
    private let list:[SubjectViewModel] = [
        .init(title: "Maths", count: 24, icon: "math"),
        .init(title: "Science", count: 12, icon: "science")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select Subjects")
                .foregroundColor(.textBlack)
                .font(.system(size: 19, weight: .medium))
                .padding(.leading, 20)
            
            ScrollView(.horizontal) {
                let rows = [GridItem(.fixed(193), spacing: 17)]
                
                LazyHGrid(rows: rows) {
                    ForEach(list) { subject in
                        NavigationLink(destination: ChapterListView()) {
                            SubjectCellView(viewModel: subject)
                                .frame(width: 156)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .background {
                    Color.base
                }
            }
            .frame(height: 193)
        }
        .background {
            Color.base
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SubjectListView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectListView()
    }
}
