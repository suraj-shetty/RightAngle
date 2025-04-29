//
//  TeachersListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import SwiftUI

struct TeachersListView: View {
    var body: some View {
        VStack(spacing: 20) {
            navView()
            TrendingTeacherView()
            RecentTeacherListView()
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
//                dismiss()
            } label: {
                Image("filter")
            }
            
            Spacer()
            
            VStack(spacing: -2) {
                Text("Teachers")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 25,
                                  weight: .medium))
                    .frame(height: 30)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image("search")
            }
        }
        .padding(20)
//        .padding(.bottom, 10)
    }
}

struct TeachersListView_Previews: PreviewProvider {
    static var previews: some View {
        TeachersListView()
    }
}
