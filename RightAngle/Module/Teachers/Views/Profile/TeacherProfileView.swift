//
//  TeacherProfileView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/08/23.
//

import SwiftUI

struct TeacherProfileView: View {
    @Namespace private var animation
    @State private var selectedTab: Int = 0
    
    @State private var navHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
//    @State private var infoHeight: CGFloat = 0
    @State private var totalHeight: CGFloat = 0
    @State private var segmentHeight: CGFloat = 0
    @State private var initialOffset: CGFloat = 0
    @State private var segmentOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                TeacherHeaderView(selectedTab: $selectedTab,
                                  height: $segmentHeight,
                                  segmentOffset: $segmentOffset,
                                  animation: animation)
                .background(Color.yellow)
                .readFrame(space: .global) { rect in
//                    print("Min Y \(rect.minY)")
//                    print("Header height \(rect.height)")
                    
                    let offset = rect.minY - initialOffset
                    let diff = offset - segmentHeight
                    
                    let htDiff = rect.height + diff - navHeight
                    
                    if htDiff < 0 {
                        self.segmentOffset = -htDiff
                    }
                    else {
                        self.segmentOffset = 0
                    }
                    
//                    print("Offset \(offset)")
//                    print("Diff \(htDiff)")
                }
                .zIndex(1)
                
                Color.red
                    .frame(height: contentHeight)
            }
            
            
        }
        .readFrame(space: .local, onChange: { rect in
            self.totalHeight = rect.height
//            self.contentHeight = totalHeight -
            calculateContentHeight()
        })
        .background(
            ZStack(alignment: .topTrailing, content: {
                Color.clear
                Image("teacherProfileCurve")
            })
            .ignoresSafeArea()
        )
        .overlay(
            VStack {
                HStack(content: {
                    Button {
                        
                    } label: {
                        Image("navBack")
                    }
                  
                    Spacer()
                })
                .padding(.leading, 18)
                .padding(.top, 20)
                .background(Color.green.opacity(0.5))
                .readFrame(space: .global) { rect in
                    self.navHeight = rect.height
                    self.initialOffset = rect.minY
                    
                    calculateContentHeight()
                    
//                    print("Nav Height \(navHeight)")
//                    print("Nav offset \(rect.minY)")
                }
//                .clipped()
                
                Spacer()
            }
                .buttonStyle(.borderless)//To allow content actions, otherwise blocked by overlay
        )
        .onChange(of: segmentHeight) { newValue in
            print("Segment height \(newValue)")
            calculateContentHeight()
        }
    }
    
    private func calculateContentHeight() {
        self.contentHeight = totalHeight - navHeight - segmentHeight //- 10
//        self.contentHeight = totalHeight - infoHeight -
    }
}

struct TeacherHeaderView: View {
    @Binding var selectedTab: Int
    @Binding var height: CGFloat
    @Binding var segmentOffset: CGFloat
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing:20) {
            TeacherProfileInfoView()
//                .readFrame(space: .global) { rect in
//
////                    let height = rect.height
////                    let minY = rect.minY
////                    let offset = rect.minY - navHeight
////                    print("Offset \(offset)")
////                    print("Info height \(height)")
//                }
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.profileSeparator)
                    .frame(height: 1)
                
                TeacherProfilePageSegment(selectedTab: $selectedTab, animation: animation)
                    .padding(.horizontal, 20)
            }
            .readFrame(space: .local) { rect in
                self.height = rect.height
            }
            .offset(x: 0, y: segmentOffset)
        }
        .onChange(of: segmentOffset) { newValue in
            print("New offset \(newValue)")
        }
    }
}

struct TeacherProfileInfoView: View {
    @State private var expandText: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                ZStack(alignment: .center) {
                    Capsule()
                        .stroke(LinearGradient(colors: Color.profileBorder,
                                               startPoint: .leading,
                                               endPoint: .trailing),
                                lineWidth: 2)
                        .frame(width: 116, height: 116)
                    
                    Image("avatar1")
                        .resizable()
                        .frame(width: 108, height: 108)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 124, height: 124)
                
                Image("teacherStar")
                    .padding(.trailing, 6)
                    .padding(.top, 13)
            }
            .padding(.top, 20)
            
            Text("Kunal Mehta")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.textBlack)
            
            HStack(spacing: 6) {
                let followersCount = "followers.count".countText(with: 12000)
                let lessonsCount = "lessons.count".countText(with: 100)
                
                Text(followersCount)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14, weight: .regular))
                    .opacity(0.7)
                
                Capsule()
                    .fill(Color.chineseSilver)
                    .frame(width: 3, height: 3)
                
                Text(lessonsCount)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14, weight: .regular))
                    .opacity(0.7)
            }
            
            ExpandableText(text: "It is a long established fact that a reader will be distracted by the readable. It is a long established fact that a reader will be distracted by the readable",
                           expand: $expandText) { element in
                
            }
                           .lineLimit(2)
                           .foregroundColor(.textBlack)
                           .font(.systemFont(ofSize: 14, weight: .semibold))                           
                           .expandButton(.init(text: "See more",
                                               font: .system(size: 14,
                                                             weight: .semibold),
                                               color: .textBlack))
            
            TeacherProfileTagListView(tagList: ["Science", "Mathematics", "Biology"])
            
            Button {
                
            } label: {
                Text("profile.follow")
            }
            .followButtonStyle()
            .padding(.top, 8)
        }
        .padding(.horizontal, 30)
    }
}

struct TeacherProfileTagListView: View {
    let tagList: [String]
    @State private var totalHeight = CGFloat(100)
//    private let gridItemLayout: [GridItem] = Array(repeating: GridItem(.adaptive(minimum: 120)),
//                                                   count: 4)
    
    var body: some View {
        GeometryReader { proxy in
            TagLayoutView(tagList,
                          tagFont: .systemFont(ofSize: 18, weight: .regular),
                          padding: 6,
                          parentWidth: proxy.size.width) { tag in
                TeacherProfileTagView(title: tag)
            }
                          .readFrame(space: .local) { rect in
                              self.totalHeight = rect.height
                          }
        }
        .frame(height: totalHeight)
        
//        LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 6) {
//            ForEach(tagList, id:\.self) { tag in
//                TeacherProfileTagView(title: tag)
//            }
//        }
    }
}

struct TeacherProfileTagView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.profileTagText)
            .frame(height: 15)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            
            .background(
                Capsule()
                    .fill(Color.profileTagBackground)
            )
    }
}

struct TeacherProfilePageSegment: View {
    @Binding var selectedTab: Int
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(id: 0,
                         title: NSLocalizedString("profile_tab_posts", comment: ""),
                         image: "post_tab",
                         isSystemImage: false,
                         animation: animation,
                         selectedTab: $selectedTab)
            
            TabBarButton(id: 1,
                         title: NSLocalizedString("profile_tab_subjects", comment: ""),
                         image: "subject_tab",
                         isSystemImage: false,
                         animation: animation,
                         selectedTab: $selectedTab)
            
            TabBarButton(id: 2,
                         title: NSLocalizedString("profile_tab_shots", comment: ""),
                         image: "shots_tab",
                         isSystemImage: false,
                         animation: animation,
                         selectedTab: $selectedTab)
        }
    }
}




struct TeacherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherProfileView()
    }
}
