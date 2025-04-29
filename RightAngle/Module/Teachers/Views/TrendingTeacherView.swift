//
//  TrendingTeacherView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import SwiftUI

struct TrendingTeacherView: View {
    @StateObject private var viewModel = TrendingTeacherListViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(spacing: 5) {
                Image("trending")
                
                Text("TOP TRENDING")
                    .foregroundColor(.trendingTitle)
                    .font(.system(size: 12, weight: .medium))
                    .frame(height: 23)
                
                Spacer()
            }
            .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack(spacing: 15) {
                    ForEach (0..<viewModel.teachers.count, id:\.self) { index in
                        cell(for: viewModel.teachers[index])
                    }
                }
                .frame(height: 118)
                .padding(.horizontal, 20)
            }
        }
    }
    
    private func cell(for viewModel: TeacherViewModel) -> some View {
        VStack(alignment: .center, spacing: 4) {
            ZStack {
                Image("trendingUserBg")
                    .resizable()
                    .frame(width: 90, height: 90)
                
                Image("Ellipse 2")
                    .resizable()
                    .frame(width: 82, height: 82)
                    .clipShape(Capsule())
            }
            
            Text(viewModel.name)
                .foregroundColor(.textBlack)
                .font(.system(size: 12, weight: .medium))
                .frame(width: 70, height: 23)
        }
    }
}

struct TrendingTeacherView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            TrendingTeacherView()
            
            Spacer()
        }
    }
}
