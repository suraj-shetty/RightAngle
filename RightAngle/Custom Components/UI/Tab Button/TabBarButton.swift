//
//  TabBarButton.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 01/08/23.
//

import SwiftUI

struct TabBarButton: View {
    var id: Int
    var title: String
    var image: String
    var isSystemImage: Bool
    var animation: Namespace.ID
    
    @Binding var selectedTab: Int
    
    var body: some View {
        Button {
            withAnimation(.linear) {
                selectedTab = id
            }
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 7) {
                    
                    (
                        isSystemImage ? Image(systemName: image) : Image(image)
                    )
                    .renderingMode(.template)
                    .foregroundColor(selectedTab == id ? .tabHighlight : .tabNormal)
                    
                    if selectedTab == id {
                        Text(title)
                            .foregroundColor(.tabHighlight)
                            .font(.system(size: 16, weight: .medium))
                            .animation(.easeInOut)
                            .transition(.opacity)
                    }
                }
                .frame(height: 54)
                
                ZStack(alignment: .bottom) {
                    if selectedTab == id {
                        Capsule(style: .circular)
                            .fill(Color.tabHighlight)
                            .frame(width: 31, height: 2)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    else {
                        Capsule(style: .circular)
                            .fill(Color.clear)
                            .frame(width: 31, height: 2)
                    }
                    
                    Rectangle()
                        .fill(Color.profileSeparator)
                        .frame(height: 1)
                }
            }
        }

    }
}

//struct TabBarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarButton()
//    }
//}
