//
//  CurriculumView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import SwiftUI

struct CurriculumView: View {
    @ObservedObject var viewModel: HomeRowViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing:0) {
            topView()
//                .ignoresSafeArea(.container, edges: .top)
            
            BookmarkCollectionView()

            SubjectListView()
                .padding(.top, 20)
            
            Spacer()
        }
        .background {
            Color.base
                .ignoresSafeArea()
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
                                
                Text(viewModel.type.title)
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
                Image("curveGrey")
            }
            .ignoresSafeArea()
            
        }
    }
}

struct CurriculumView_Previews: PreviewProvider {
    static var previews: some View {
        CurriculumView(viewModel: .init(type: .curriculum, count: 20))
    }
}
