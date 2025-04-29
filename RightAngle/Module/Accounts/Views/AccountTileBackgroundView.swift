//
//  AccountTileBackgroundView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/04/23.
//

import SwiftUI

struct AccountTileBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.accountCardBg)
            
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.accountCardBorder,
                        lineWidth: 2)
        }
    }
}

struct AccountTileBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTileBackgroundView()
    }
}
