//
//  RecentTeacherListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/03/23.
//

import SwiftUI

struct RecentTeacherListView: View {
    @StateObject private var viewModel = TeacherListViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 11) {
                HStack {
                    Text("SORT BY")
                        .foregroundColor(.grey1)
                        .font(.system(size: 12, weight: .medium))
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                ScrollView(.horizontal,
                           showsIndicators: false) {
                    LazyHStack(alignment: .center,
                               spacing: 5) {
                        sortOptionView(with: "Popular")
                        sortOptionView(with: "Highest Views")
                        sortOptionView(with: "Highest Stars")
                        sortOptionView(with: "Date Added")
                    }
                               .padding(.horizontal, 20)
                }
            }
            .frame(height: 69)
            
            Divider()
                .background {
                    Color.teacherSectionSeparator
                }
            
            List {
                HStack {
                    Text("RECENT SEARCH")
                        .foregroundColor(.trendingTitle)
                        .font(.system(size: 12, weight: .medium))
                    
                    Spacer()
                }
                    .listRowInsets(.init(top: 13,
                                         leading: 19,
                                         bottom: 0, trailing: 20))
                    .listRowSeparatorTint(.chapterSeparator)
                    .listRowSeparator(.hidden, edges: .top)
                
                
                ForEach(0..<viewModel.teachers.count, id: \.self) { index in
                    cellView(for: viewModel.teachers[index])
                }
            }
            .listStyle(.plain)
            .padding(.top, -20)
        }
    }
    
    private func sortOptionView(with title:String) -> some View {
        ZStack {
            Text(title)
                .foregroundColor(.textBlack)
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
        }
        .background {
            Capsule()
                .fill(Color.paleBlue)
        }
    }
    
    private func cellView(for viewModel: TeacherViewModel) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image("Ellipse 2")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Capsule())
            
            VStack(alignment: .leading,
                   spacing: 7) {
                Text(viewModel.name)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 18, weight: .medium))
                    .frame(height: 23)
                    .lineLimit(1)
                
                Text("12K Followers")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14, weight: .regular))
                    .frame(height: 11)
                    .opacity(0.5)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Follow")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.horizontal, 26)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color.paleGreen)
                    }
            }
        }
        .buttonStyle(.borderless)
        .listRowInsets(.init(top: 20,
                             leading: 20,
                             bottom: 22, trailing: 20))
        .listRowSeparatorTint(.teacherSectionSeparator)
        .listRowSeparator(.hidden, edges: .top)
    }
}

struct RecentTeacherListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentTeacherListView()
    }
}
