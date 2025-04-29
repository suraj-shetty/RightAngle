//
//  AddAccountView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 17/03/23.
//

import SwiftUI
import PartialSheet

enum AddAccountMode: Int {
    case onboard
    case addChild
    case edit
}

struct AddAccountView: View {
    private var mode: AddAccountMode
    
    @Environment(\.dismiss) private var dismiss
    @State private var pickLocation: Bool = false
    @State private var pickGrade: Bool = false
    @State private var pickBoard: Bool = false
    @State private var pickMedium: Bool = false
    @State private var pickAvatar: Bool = false
    @State private var canSubmit: Bool = false
    
    @State private var pickedGrade: PickerOption? = nil
    @State private var pickedBoard: PickerOption? = nil
    @State private var pickedMedium: PickerOption? = nil
    @State private var pickedAvatar: String? = "avatar1"
    @State private var pickedLocation: PickerOption? = nil
    
    private let viewModel = AddAccountViewModel()
    
    init(mode: AddAccountMode) {
        self.mode = mode
    }
    
    var body: some View {
        ZStack(content: {
            VStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 22) {
                        
                        Button {
                            pickAvatar.toggle()
                        } label: {
                            ZStack {
                                if let name = pickedAvatar, !name.isEmpty {
                                    Image(name)
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                }
                                Color.davyGrey
                                    .opacity(0.6)
                                    .frame(width: 120, height: 120)
                                    .clipShape(Capsule())
                                
                                Image("pencil")
                            }
                        }
                        .padding(.bottom, 7)
                        
                        
                        
                        pickerField(with: "Select your location", value: viewModel.pickedLocation?.name ?? "")
                            .onTapGesture {
                                pickLocation.toggle()
                            }
                        
//                        pickerField(with: "Select your education", value: picked)
                        
                        
                        pickerField(with: "Select your grade", value: pickedGrade?.name ?? "")
                            .onTapGesture {
//                                if viewModel.gr
                                pickGrade.toggle()
                            }
                        
                        pickerField(with: "Select your board", value: pickedBoard?.name ?? "")
                            .onTapGesture {
                                pickBoard.toggle()
                            }
                        
                        pickerField(with: "Medium of instructions", value: pickedMedium?.name ?? "")
                            .onTapGesture {
                                pickMedium.toggle()
                            }
                    }
                    .padding(20)
                }
                
                Spacer()
                
                Button {
                    switch self.mode {
                    case .onboard:
                        NotificationCenter.default
                            .post(name: .loggedIn,
                                  object: nil)
                        
                    case .addChild, .edit:
                        self.dismiss()
                    }
                } label: {
                    Text(submitTitle())
                }
                .buttonStyle(SubmitButtonStyle())
                .disabled(!canSubmit)
                .padding(.horizontal, 20)
            }
        })
        .background {
            Color.base
                .ignoresSafeArea()
        }
        .onChange(of: viewModel.loading) { newValue in
            if newValue == true {
                AlertUtility.showHUD()
            }
            else {
                AlertUtility.hidHUD()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title())
                    .foregroundColor(.navText)
                    .font(.system(size: 25,
                                  weight: .medium))
            }
            
//            if mode == .addChild {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.dismiss()
                    } label: {
                        Image("navClose")
                    }
                    .opacity(mode == .onboard ? 0.0 : 1.0)
                }
//            }
        }
        .task {
            await viewModel.fetchDetails()
        }
        .partialSheet(isPresented: $pickLocation,
                      iPhoneStyle:  .init(background: .solid(.clear),
                                          handleBarStyle: .solid(.paleGrey4),
                                          cover: .enabled(.black.opacity(0.59)),
                                          cornerRadius: 20))
        {
            PickerView(viewModel: .init(title: "Select your location",
                                        options: viewModel.locations.map({
                PickerOption(id: $0.id,
                             name: $0.name)
            }),
                                        picked: (viewModel.pickedLocation != nil) ? PickerOption(id: viewModel.pickedLocation!.id, name: viewModel.pickedLocation!.name
                                                                                       ) : nil
                                       ),
                       onPicked: { picked in
                
                viewModel.pickedLocation = viewModel.locations.first(where: { $0.id == picked?.id })
                self.updateState()
                self.pickLocation.toggle()
            })
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .background {
                Color.base
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y:20)
            }
        }
        
        .partialSheet(isPresented: $pickGrade, iPhoneStyle: .init(background: .solid(.clear),
                                                                  handleBarStyle: .solid(.paleGrey4),
                                                                  cover: .enabled(.black.opacity(0.59)),
                                                                  cornerRadius: 20))
        {
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
                                        ],
                                        picked: pickedGrade),
                       onPicked: { picked in
                self.pickedGrade = picked
                self.updateState()
                self.pickGrade.toggle()
            })
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .background {
                Color.base
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y:20)
            }
        }
        
        .partialSheet(isPresented: $pickBoard, iPhoneStyle: .init(background: .solid(.clear),
                                                                  handleBarStyle: .solid(.paleGrey4),
                                                                  cover: .enabled(.black.opacity(0.59)),
                                                                  cornerRadius: 20))
        {
            PickerView(viewModel: .init(title: "Select your board",
                                        options: [
                                            PickerOption(id: 1, name: "MPBSE"),
                                            PickerOption(id: 2, name: "RBSE"),
                                            PickerOption(id: 3, name: "ICSE"),
                                            PickerOption(id: 4, name: "NIOS"),
                                            PickerOption(id: 5, name: "WBBSE"),
                                            PickerOption(id: 6, name: "BSEH")
                                        ],
                                        picked: pickedBoard),
                       onPicked: { picked in
                self.pickedBoard = picked
                self.updateState()
                self.pickBoard.toggle()
            })
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .background {
                Color.base
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y:20)
            }
        }
        .partialSheet(isPresented: $pickMedium, iPhoneStyle: .init(background: .solid(.clear),
                                                                  handleBarStyle: .solid(.paleGrey4),
                                                                  cover: .enabled(.black.opacity(0.59)),
                                                                  cornerRadius: 20))
        {
            PickerView(viewModel: .init(title: "Select your medium",
                                        options: [
                                            PickerOption(id: 1, name: "English"),
                                            PickerOption(id: 2, name: "Kannada"),
                                            PickerOption(id: 3, name: "Hindi")
                                        ],
                                        picked: pickedMedium),
                       onPicked: { picked in
                self.pickedMedium = picked
                self.updateState()
                self.pickMedium.toggle()
            })
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .background {
                Color.base
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y:20)
            }
        }
        .partialSheet(isPresented: $pickAvatar,
                      iPhoneStyle: .init(background: .solid(.clear),
                                         handleBarStyle: .solid(.paleGrey4),
                                         cover: .enabled(.black.opacity(0.59)),
                                         cornerRadius: 20))
        {
            AvatarPickerView(viewModel: .init(title: "Choose Profile Icon",
                                              options: [
                                                "avatar1",
                                                "avatar2",
                                                "avatar3",
                                                "avatar4",
                                                "avatar5",
                                                "avatar6",
                                              ],
                                              picked: nil)) { value in
                self.pickedAvatar = value
                self.pickAvatar.toggle()
            }
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .background {
                Color.base
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y:20)
            }
        }
    }
    
    private func pickerField(with title:String, value:String) -> some View {
        HStack {
            Text(value.isEmpty ? "Select option" : value)
                .foregroundColor(.textBlack)
                .opacity(value.isEmpty ? 0.5 : 1.0)
                .font(.system(size: 16, weight: .regular))
            
            Spacer()
            
            Image("dropArrow")
        }
        .inputField(with: title)
    }
    
    private func updateState() {
        let canSubmit = (pickedGrade != nil) && (pickedBoard != nil) && (pickedMedium != nil)
        self.canSubmit = canSubmit
    }
    
    private func title() -> String {
        switch mode {
        case .onboard:
            return "Choose your preference"
        case .addChild:
            return "Create Children Profile"
        case .edit:
            return "Edit Profile"
        }
    }
    
    private func submitTitle() -> String {
        switch mode {
        case .onboard:
            return "Complete"
        case .addChild:
            return "Complete"
        case .edit:
            return "Save & Update"
        }
    }
}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddAccountView(mode: .onboard)
        }
    }
}
