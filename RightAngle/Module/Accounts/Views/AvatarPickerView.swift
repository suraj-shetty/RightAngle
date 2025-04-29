//
//  AvatarPickerView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 07/04/23.
//

import SwiftUI

struct AvatarPickerView: View {
    @StateObject var viewModel: AvatarPickerViewModel
    private let callBack:(String?)->()
    
    init(viewModel: AvatarPickerViewModel, callBack: @escaping (String?) -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.callBack = callBack
    }
    
    
    var body: some View {
        VStack(spacing:21) {
            Text(viewModel.title)
                .foregroundColor(.textBlack)
                .opacity(0.5)
                .font(.system(size: 14, weight: .medium))
                .padding(.top, 30)
            
            let columns = Array<GridItem>(repeating: GridItem(.adaptive(minimum: 104)), count: 3)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.options, id:\.self) { option in
                    cell(for: option)
                        .onTapGesture {
                            self.callBack(option)
                        }
                }
            }
            .padding(.top, 2)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .background {
            Color.base
        }
    }
    
    private func cell(for item: String) -> some View {
        Image(item)
        .id(item)
//        .onTapGesture {
//            self.viewModel.picked = item
//        }
    }
}

struct AvatarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPickerView(viewModel: .init(title: "Choose Profile Icon",
                                          options: [
                                            "avatar1",
                                            "avatar2",
                                            "avatar3",
                                            "avatar4",
                                            "avatar5",
                                            "avatar6",
                                          ],
                                          picked: nil)) { _ in
            
        }
    }
}
