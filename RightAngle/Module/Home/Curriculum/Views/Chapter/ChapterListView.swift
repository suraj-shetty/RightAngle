//
//  ChapterListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/02/23.
//

import SwiftUI

struct ChapterListView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let list: [ChapterViewModel] = [
        .init(title: "Plants", index: 1),
        .init(title: "Animals Life", index: 2),
        .init(title: "How animals see colours", index: 3),
        .init(title: "Human body", index: 4)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            topView()
            
            Text("Select Chapter")
                .textCase(.uppercase)
                .foregroundColor(.chapterListTitle)
                .font(.system(size: 12, weight: .medium))
                .padding(.top, 23)
                .padding(.bottom, 13)
                .padding(.leading, 19)
            
            List(list) { chapter in
                NavigationLink(destination: SubjectDetailView()) {
                    ChapterCellView(viewModel: chapter)
                }
                    .listRowBackground(Color.base)
                    .listRowInsets(.init(top: 0, leading: 20, bottom: 15, trailing: 20))
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func topView() -> some View {
        HStack {
            VStack(alignment:.leading, spacing: 0) {
                Button {
                    self.dismiss()
                } label: {
                    Image("navBack")
                }
                                
                Text("Science")
                    .foregroundColor(.curriculumTitle)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 13)
                    .padding(.bottom, 7)
                
                Text("Grade 7, ICSE")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 26, weight: .medium))
            }
            
            Spacer()
        }
        .padding(.init(top: 30,
                       leading: 18, bottom: 40,
                       trailing: 0))
//        .frame(height: 214)
        .background {
            ZStack(alignment: .topTrailing) {
                Color.curriculumHeader
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                Image("curveGrey2")
            }
            .ignoresSafeArea()
            
        }
    }
}

struct ChapterListView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListView()
    }
}
