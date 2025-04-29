//
//  SegmentItemView.swift
//  StarGaze
//
//  Created by Suraj Shetty on 24/05/22.
//  Copyright © 2022 Day1Tech. All rights reserved.
//

import SwiftUI


struct SegmentItemView: View {
    var iconName:String = ""
    var title:String = ""
    var isHighlighted:Bool = false
    var hideText: Bool = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 10, content: {
            if !iconName.isEmpty {
                Image(iconName)
                    .renderingMode(.template)
                    .frame(height:22)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(isHighlighted ? .textBlack : .textBlack.opacity(0.6))
            }
            
            if !hideText || isHighlighted {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(isHighlighted ? .textBlack : .textBlack.opacity(0.6))
            }
        })
    }
}

struct SegmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentItemView(iconName: "feedsSegment", title: "Feeds", isHighlighted: true)
    }
}
