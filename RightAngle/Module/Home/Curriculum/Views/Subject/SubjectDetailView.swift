//
//  SubjectDetailView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 08/03/23.
//

import SwiftUI

struct SubjectDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var orientation = UIDeviceOrientation.portrait
    @State private var topInset: CGFloat = 0
    @State private var labelExpand: Bool = false
    
    private let segments = [
        SegmentItemViewModel(title: "Lessons", iconName: ""),
        SegmentItemViewModel(title: "Comments", iconName: "")
    ]
    
    @State private var segmentIndex: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                
                Color.base
                    .frame(maxWidth: .infinity, maxHeight: orientation == .portrait
                           ? 313 - proxy.safeAreaInsets.top
                           : .infinity)
                    .ignoresSafeArea(.all, edges: .top)
                
                SegmentedView(selectedIndex: $segmentIndex,
                              segments: segments,
                              showText: true)
                
                contentView(at: segmentIndex)
            }
        }
        .background(content: {
            Color.base
                .ignoresSafeArea()
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .overlay(content: {
            VStack(spacing: 0) {
                
                ZStack(alignment: .top) {
                    ZStack {
                        Color.paleGrey
                        Color.black.opacity(0.5)
                    }
                    .frame(height: orientation == .portrait ? 313 : .infinity)
                    .ignoresSafeArea(.all, edges: orientation == .portrait ? .top : .all)
                    
                    HStack(spacing: 26) {
                        Button {
                            dismiss()
                        } label: {
                            Image("navBack")
                                .renderingMode(.template)
                                .tint(.textWhite)
                                .frame(height: 50)
                        }

                        if orientation.isLandscape {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("How wild animals see colors and find food for living")
                                    .foregroundColor(.textWhite)
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text("Kunal Mehta")
                                    .foregroundColor(.textWhite)
                                    .font(.system(size: 16, weight: .medium))
                                    .opacity(0.6)
                                    .lineSpacing(7)
                            }
                        }
                        
                        Spacer()
                    }
                    .ignoresSafeArea(.all, edges: .horizontal)
                    .padding(.horizontal, 20)
                    .padding(.top, orientation.isLandscape ? 31 : 0)
                }
                
                if orientation == .portrait {
                    Spacer()
                }
            }
        })
        .onAppear(perform: {
//            self.topInset = UIScene.
//            self.orientation = UIDevice.current.orientation
            AppDelegate.orientationLock = .allButUpsideDown
        })
        .onDisappear(perform: {
            AppDelegate.orientationLock = .portrait
        })
        .onRotate { newOrientation in
            self.orientation = newOrientation
        }
    }
    
    private func infoView() -> some View {
        VStack(alignment: .leading,
               spacing: 9) {
            HStack(spacing: 9) {
                Text("Grade 8, ICSE")
                    .foregroundColor(.chapterListTitle)
                    .font(.system(size: 12, weight: .medium))
                
                Image("greyArrow")
                
                Text("Science")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(height: 23)
            
            Text("How wild animals see colors and find food for living - English")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.textBlack)
                .lineSpacing(4)
                .lineLimit(0)
            
            ExpandableText(text: "This Science Full Course video will help you understand and learn Data Science. This Science Full Course video will help you understand and learn Data Science. This Science Full Course video will help you understand and learn Data Science.",
                           expand: $labelExpand) { element in
                
            }
                           .font(.systemFont(ofSize: 14, weight: .regular))
                           .foregroundColor(.textBlack)
                           .lineLimit(2)
                           .expandButton(.init(text: "See more",
                                               font: .system(size: 14, weight: .semibold),
                                               color: .textBlack))
//                           .expandAnimation(.easeIn)
//                           .lineLimit(2)
                           .opacity(0.6)
            
            HStack(spacing: 9) {
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image("like")
                        
                        Text("134")
                            .foregroundColor(.textBlack)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color.chapterSeparator)
                    }
                }
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image("bookmark")
                        
                        Text("Bookmark")
                            .foregroundColor(.textBlack)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color.chapterSeparator)
                    }
                }
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image("share")
                        
                        Text("Share")
                            .foregroundColor(.textBlack)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color.chapterSeparator)
                    }
                }
            }
            
            HStack(spacing: 9) {
                Image("Ellipse 2")
                    .frame(width: 40, height: 40)
                    .clipShape(Capsule())
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("Priyanka Gupta")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .medium))
                        .frame(height: 23)
                    
                    Text("12K Followers")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 12, weight: .medium))
                        .opacity(0.5)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .fill(Color.paleGreen)
                        }
                    
                }

            }
            .padding(.top, 28)
            
        }
               .buttonStyle(.borderless)
//               .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in
//                   return 0
//               })
               .listRowInsets(.init(top: 13,
                                    leading: 20,
                                    bottom: 20,
                                    trailing: 20))
               .listRowSeparator(.hidden, edges: .top)
               .listRowSeparatorTint(.chapterSeparator)
    }
    
    private func cellView(with title:String, duration: String) -> some View {
        HStack(spacing: 15) {
            Image("lock")
            
            Text(title)
                .foregroundColor(.textBlack)
                .font(.system(size: 14, weight: .medium))
            
            Spacer()
            
            Text(duration)
                .foregroundColor(.textBlack)
                .font(.system(size: 12, weight: .medium))
                .opacity(0.5)
        }
        .listRowInsets(.init(top: 20,
                             leading: 20,
                             bottom: 20,
                             trailing: 20))
        .listRowSeparator(.hidden, edges: .top)
        .listRowSeparatorTint(.chapterSeparator)
        
    }
    
    private func chapterList() -> some View {
        List {
            infoView()
            cellView(with: "Chapter 1", duration: "28:45")
            cellView(with: "Chapter 2", duration: "29:23")
            cellView(with: "Chapter 3", duration: "30:04")
            cellView(with: "Chapter 4", duration: "27:51")
            cellView(with: "Chapter 5", duration: "29:19")
            cellView(with: "Chapter 6", duration: "28:55")
        }
        .listStyle(.plain)
    }
    
    private func commentCellView(with text:String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image("Ellipse 2")
                .frame(width: 45, height: 45)
                .clipShape(Capsule())
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Albert Flores")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 12, weight: .medium))
                    .opacity(0.5)
                
                Text(text)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14, weight: .medium))
                    .lineSpacing(9)
                
                HStack(alignment: .center, spacing: 9) {
                    Text("2hr")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 12, weight: .medium))
                        .opacity(0.5)

                    Capsule()
                        .fill(Color.strokeBorder)
                        .frame(width: 3, height: 3)
                    
                    Text("9 likes")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 12, weight: .medium))
                        .opacity(0.5)
                    
                    Capsule()
                        .fill(Color.strokeBorder)
                        .frame(width: 3, height: 3)
                    
                    Button {
                        
                    } label: {
                        Text("Reply")
                            .foregroundColor(.textBlack)
                            .font(.system(size: 12, weight: .medium))
                            .opacity(0.5)
                    }
                }
            }
            
            Spacer()
        }
        .buttonStyle(.borderless)
        .listRowInsets(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
        .listRowSeparator(.hidden)
    }
    
    private func commentHeaderView() -> some View {
        HStack{
            Text("29 Comments")
                .foregroundColor(.textBlack)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
        }
        .listRowInsets(.init(top: 23, leading: 20, bottom: 4, trailing: 20))
        .listRowSeparator(.hidden)
    }
    
    private func commentList() -> some View {
        List {
            commentHeaderView()
            commentCellView(with: "Great tutor ever!")
            commentCellView(with: "Problem solving lecture")
            commentCellView(with: "Great tutor ever!")
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private func contentView(at index: Int) -> some View {
        switch index {
        case 1: commentList()
        default: chapterList()
        }
    }
}

struct SubjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectDetailView()
    }
}
