//
//  PickerView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/04/23.
//

import SwiftUI

struct PickerView: View {
    @StateObject var viewModel: PickerViewModel
    
    private let callBack:(PickerOption?)->()
    
    init(viewModel: PickerViewModel, onPicked:@escaping (PickerOption?)->()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.callBack = onPicked
    }
    
    var body: some View {
        VStack(spacing:21) {
            Text(viewModel.title)
                .foregroundColor(.textBlack)
                .opacity(0.5)
                .font(.system(size: 14, weight: .medium))
                .padding(.top, 30)
            
            let columns = Array<GridItem>(repeating: GridItem(.adaptive(minimum: 120)), count: 2)
            
            LazyVGrid(columns: columns, spacing: 11) {
                ForEach(viewModel.options) { option in
                    cell(for: option)
                }
            }
            .padding(.top, 2)
            .padding(.horizontal, 20)
            
            Button {
                self.callBack(viewModel.picked)
            } label: {
                Text("Done")
            }
            .buttonStyle(SubmitButtonStyle())
            .disabled(viewModel.picked == nil)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)

        }
        .background {
            Color.base
        }
    }
    
    private func cell(for item: PickerOption) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.base)
            
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.strokeBorder,
                        lineWidth: 2)
                .opacity(0.5)
            
            
            HStack {
                Text(item.name)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14,
                                  weight: .medium))
                
                Spacer()
                
                if viewModel.picked == item {
                    Image("verified")
                        .resizable()
                        .frame(width: 19, height: 19)
                }
                else {
                    Circle()
                        .fill(Color.optionEmpty)
                        .frame(width: 19, height: 19)
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 60)
        .id(item.id)
        .onTapGesture {
            self.viewModel.picked = item
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: .init(title: "Select your grade",
                                    options: [
                                        PickerOption(id: 1, name: "Grade 6"),
                                        PickerOption(id: 2, name: "Grade 7"),
                                        PickerOption(id: 3, name: "Grade 8"),
                                        PickerOption(id: 4, name: "Grade 9"),
                                        PickerOption(id: 5, name: "Grade 10"),
                                        PickerOption(id: 6, name: "Grade 11"),
                                        PickerOption(id: 7, name: "Grade 12"),
                                        PickerOption(id: 8, name: "Grade 13"),
                                        
                                    ], picked: nil), onPicked: { picked in
//                                        self.pickedGrade = picked
                                    })
    }
}
