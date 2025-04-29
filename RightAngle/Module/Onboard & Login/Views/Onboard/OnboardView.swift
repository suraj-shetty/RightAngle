//
//  OnboardView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 16/02/23.
//

import SwiftUI
import SwiftDate


struct OnboardView: View {
    @StateObject private var viewModel = OnboardViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: OnboardField?
    @State private var loadCountryPicker: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: AddAccountView(mode: .onboard),
                           isActive: $viewModel.didSignup) {
                EmptyView()
            }            
            VStack(spacing: .zero) {
                ScrollViewReader { scrollProxy in
                    
                    List {
                        nameInputField()
                        userNameField()
                        emailAddressField()
                        dateField()
                        referralCodeField()
                        phoneField()
                        
                        switch viewModel.otpStatus {
                        case  .unknown:
                            HStack {
                                Spacer()
                                
                                Button {
                                    Task.detached {
                                        await viewModel.requestOTP()
                                    }
                                } label: {
                                    Text("Verify Phone Number")
                                        .foregroundColor(.textBlack)
                                        .font(.system(size: 16, weight: .semibold))
                                        .underline()
                                }
                                .padding()
                                
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.base)
                            
                            
                        case .duration(_):
                            otpInputField()
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    Task.detached {
                                        await viewModel.requestOTP()
                                    }
                                } label: {
                                    Text("Send me a new code")
                                        .foregroundColor(.textBlack)
                                        .font(.system(size: 16, weight: .semibold))
                                        .underline()
                                }
                                .padding()
                                .disabled(!viewModel.allowPinRequest)
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.base)
                            
                        case .verified:
                            otpInputField()
                        }
                        
                        termsView()
                        
                        bottomView()
                    }
                    .listStyle(.plain)
                    .onChange(of: focusedField) { newValue in
                        guard let field = newValue
                        else { return }
                        
                        scrollProxy.scrollTo(field)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button {
                            if let field = self.focusedField {
                                Task.detached {
                                    await self.viewModel.verifyInput(of:field)
                                }
                            }
                            
                            self.focusedField = nil
                        } label: {
                            Text("Done")
                                .foregroundColor(.textBlack)
                                .font(.system(size: 15, weight: .regular))
                        }
                    }
                }
            }
            .padding(.top, 10)
        }
        .background {
            Color.background
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavBackButton(dismiss: self.dismiss)
            }
            
            ToolbarItem(placement: .principal) {
                Text("Sign Up")
                    .foregroundColor(.navText)
                    .font(.system(size: 25,
                                  weight: .medium))
            }
            
//            ToolbarItem(placement: .keyboard) {
//                VStack {
//                    Spacer()
//                    Button {
//                        self.isFocussed = false
//                    } label: {
//                        Text("Done")
//                            .foregroundColor(.white)
//                    }
//
//                }
//            }
        }
        .onChange(of: viewModel.loading) { newValue in
            if newValue == true {
                AlertUtility.showHUD()
            }
            else {
                AlertUtility.hidHUD()
            }
        }
        .onChange(of: focusedField) {[focusedField] newValue in
            print("Old field \(String(describing: focusedField))")
            print("New Field \(String(describing: newValue))")
        }
        //        .onChange(of: viewModel.didSignup) { newValue in
        //            if newValue {
        //                let homeVC = UIHostingController(rootView: SideMenuView())
        //
        //                if let scene = UIApplication.shared.connectedScenes.first,
        //                   let window = (scene as? UIWindowScene)?.keyWindow {
        //                    window.set(rootViewController: homeVC,
        //                               options: .init(direction: .toRight,
        //                                              style: .easeOut)) { _ in
        //                    }
        //                }
        //            }
        //        }
//    }
    }
    
    private func nameInputField() -> some View {
        TextField(text: $viewModel.name, label: {
            Text("Your name")
                .foregroundColor(.textPlaceholder)
                .font(.system(size: 16,
                              weight: .regular))
        })
        .foregroundColor(.textBlack)
        .font(.system(size: 16,
                      weight: .regular))
        .tint(.textBlack)
        .focused($focusedField, equals: .name)
        .submitLabel(.next)
        .textInputAutocapitalization(.words)
        .autocorrectionDisabled()
        .onSubmit {
            viewModel.updateInputState()
            self.focusedField = .userName
        }
        .inputField(with: "Name")
        .id(OnboardField.name)
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.background)
    }
    
    private func userNameField() -> some View {
        HStack(spacing: 10, content: {
            TextField(text: $viewModel.username, label: {
                Text("@yourname")
                    .foregroundColor(.textPlaceholder)
                    .font(.system(size: 16,
                                  weight: .regular))
            })
            
            .foregroundColor(.textBlack)
            .font(.system(size: 16,
                          weight: .regular))
            .tint(.textBlack)
            .keyboardType(.default)
            .textCase(.lowercase)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($focusedField, equals: .userName)
            .submitLabel(.next)
            .onSubmit {
                self.focusedField = .emailAddress
                
                if viewModel.userNameStatus != .verified {
                    Task.detached {
                        await self.viewModel.checkUserName()
                    }
                }
            }
            .onChange(of: viewModel.username, perform: { _ in
                if viewModel.userNameStatus != .unverified {
                    viewModel.userNameStatus = .unverified
                    viewModel.updateInputState()
                }
            })
            
            switch viewModel.userNameStatus {
            case .verifying:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.textBlack.opacity(0.8))
                
            case .verified:
                Image("verified")
                
            default:
                EmptyView()
            }
        })
        .inputField(with: "User Name")
        .id(OnboardField.emailAddress)
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.base)
    }
    
    private func emailAddressField() -> some View {
        HStack(spacing: 10, content: {
            TextField(text: $viewModel.email, label: {
                Text("Your email address")
                    .foregroundColor(.textPlaceholder)
                    .font(.system(size: 16,
                                  weight: .regular))
            })
            .foregroundColor(.textBlack)
            .font(.system(size: 16,
                          weight: .regular))
            .tint(.textBlack)
            .keyboardType(.emailAddress)
    //        .textCase(.lowercase)
            .textInputAutocapitalization(.never)
            .focused($focusedField, equals: .emailAddress)
            .submitLabel(.next)
            .onSubmit {
                self.focusedField = .birthDate
                
                if viewModel.emailStatus != .verified {
                    Task.detached {
                        await self.viewModel.checkEmailAddress()
                    }
                }
            }
            .onChange(of: viewModel.email, perform: { _ in
                if viewModel.emailStatus != .unverified {
                    viewModel.emailStatus = .unverified
                    viewModel.updateInputState()
                }
            })
            
            switch viewModel.emailStatus {
            case .verifying:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.textBlack.opacity(0.8))
                
            case .verified:
                Image("verified")
                
            default:
                EmptyView()
            }
        })
        .inputField(with: "Email Address")
        .id(OnboardField.emailAddress)
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.background)
    }
    
    @ViewBuilder
    private func countryView() -> some View {
        if let country = viewModel.country {
            HStack(alignment: .center,
                   spacing: 10) {
                Image(uiImage: country.flagImage ?? UIImage())
                    .resizable()
                    .frame(width: 25,
                           height: 19)
                    .aspectRatio(contentMode: .fit)
                
                Text("+\(country.phoneCode!)")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16,
                                  weight: .regular))
                
                Image("dropArrow")
            }
        }
        else {
            EmptyView()
        }
    }
    
    private func dateField() -> some View {
        ZStack(alignment: .leading) {
            SGBirthDatePickerField(date: $viewModel.birthDate,
                                   maxDate: Date() - 16.years,
                                   textColor: .clear)
            
            
            if viewModel.birthDate == nil {
                Text("Pick a date")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16,
                                  weight: .regular))
                    .opacity(0.54)
                    .disabled(true)
            }
            
            HStack(alignment: .center,
                   spacing: 7) {
                if let date = viewModel.birthDate {
                    Text(String(format: "%2d", date.day))
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .regular))
                    
                    Text("-")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .regular))
                        .opacity(0.3)
                    
                    Text(String(format: "%2d", date.month))
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .regular))
                    
                    Text("-")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .regular))
                        .opacity(0.3)
                    
                    Text(String(date.year))
                        .foregroundColor(.textBlack)
                        .font(.system(size: 16, weight: .regular))
                }
                
                Spacer()
                
                Text("Optional")
                    .font(.system(size: 16,
                                  weight: .regular))
                    .foregroundColor(.textBlack)
                    .opacity(0.25)
            }
                   .disabled(true)
        }
        .inputField(with: "Date Of Birth")
        
        .id(OnboardField.birthDate)
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.base)
    }
    
    private func referralCodeField() -> some View {
        HStack(alignment: .center,
               spacing: 7) {
            TextField(text: $viewModel.referralCode, label: {
                Text("000000")
                    .foregroundColor(.textPlaceholder)
                    .font(.system(size: 16,
                                  weight: .regular))
            })
            .foregroundColor(.textBlack)
            .font(.system(size: 16,
                          weight: .regular))
            .tint(.textBlack)
            .keyboardType(.default)
            .textCase(.lowercase)
            .textInputAutocapitalization(.never)
            .focused($focusedField, equals: .code)
            .submitLabel(.next)
            .onSubmit {
                viewModel.updateInputState()
                self.focusedField = .phoneNumber
            }
            
            Spacer()
            
            Text("Optional")
                .font(.system(size: 16,
                              weight: .regular))
                .foregroundColor(.textBlack)
                .opacity(0.25)
        }
               .disabled(true)
               .inputField(with: "Referral Code")
        
               .id(OnboardField.code)
               .listRowInsets(.init(top: 10,
                                    leading: 20,
                                    bottom: 10,
                                    trailing: 20))
               .listRowSeparator(.hidden)
               .listRowBackground(Color.base)
    }
    
    private func phoneField() -> some View {
        HStack(alignment: .center,
               spacing: 10) {
            
            countryView()
                .onTapGesture {
                    self.loadCountryPicker = true
                }
                .sheet(isPresented: $loadCountryPicker, content: {
                    CountryPickerViewProxy { choosenCountry in
                        let code = choosenCountry.countryCode
                        self.viewModel.switchCountry(with: code)
                    }
                })
                .presentationDetents([.large])
            
                TextField(text: $viewModel.phoneNumber, label: {
                    Text("1234567890")
                        .foregroundColor(.textPlaceholder)
                        .font(.system(size: 16,
                                      weight: .regular))
                })
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16,
                                  weight: .regular))
                    .tint(.textBlack)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .phoneNumber)
                    .submitLabel(.done)
                    .onChange(of: viewModel.phoneNumber, perform: { newValue in
                        if newValue.count == 10 {
                            self.focusedField = nil
                        }
                    })
                    .onSubmit {
                        viewModel.updateInputState()
                        self.focusedField = nil
                    }
        }
               .inputField(with: "Phone Number")
               .id(OnboardField.phoneNumber)
        //        .frame(height: 76)
               .listRowInsets(.init(top: 10,
                                    leading: 20,
                                    bottom: 10,
                                    trailing: 20))
               .listRowSeparator(.hidden)
               .listRowBackground(Color.base)
    }
    
    private func otpInputField() -> some View {
        HStack {
            OTPView(otpCode: $viewModel.otp,
                    otpCodeLength: 4,
                    textColor: .textBlack,
                    textSize: 16)
            .frame(width: 154)
            .focused($focusedField, equals: .otp)
            .onChange(of: viewModel.otp) { newValue in
                if newValue.count == 4 {
                    self.focusedField = nil
                    Task.detached {
                        await self.viewModel.verifyPin()
                    }
                }
            }
            .onAppear {
                switch viewModel.otpStatus {
                case .verified: break
                default: self.focusedField = .otp
                }
            }
            Spacer()
            
            switch viewModel.otpStatus {
            case .unknown: EmptyView()
            case .verified:
                Image("verified")
                
            case .duration(let duration):
                Text(
                    duration.toString {
                        $0.maximumUnitCount = 2
                        $0.allowedUnits = [.minute, .second]
                        $0.collapsesLargestUnit = false
                        $0.unitsStyle = .positional
                        $0.zeroFormattingBehavior = .pad
                    }
                )
                .foregroundColor(.textBlack)
                .opacity(0.55)
                .font(.system(size: 16, weight: .regular))
            }
        }
        .padding(.trailing, 26)
        .inputField(with: "Verification Code")
        .id(OnboardField.otp)
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.base)
    }
    
    private func termsView() -> some View {
        HStack(alignment: .top, spacing: 10) {
            Spacer()
            
            CheckBoxView(checked: $viewModel.didAgree)
            
            Text("I agree with [Terms](https://stargaze.ai/terms-and-conditions), [Privacy Policy](https://stargaze.ai/privacy-policy)")
                .font(.system(size: 16,
                              weight: .medium))
                .foregroundColor(.infoText)
                .tint(.textBlack)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
            
            Spacer()
        }
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 10))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.base)
    }
    
    private func bottomView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            
            Button {
                Task.detached {
                    await viewModel.onboard()
                }
            } label: {
                Text("Sign Up")
            }
            .buttonStyle(SubmitButtonStyle())
            .disabled(!viewModel.canSubmit)
            .opacity(viewModel.canSubmit ? 1.0 : 0.44)
            
            Text("Already have an account? [Login](open://sign-in)")
                .foregroundColor(.textBlack)
                .font(.system(size: 16, weight: .semibold))
                .tint(.infoText)
                .environment(\.openURL, OpenURLAction(handler: { _ in
                    
                    dismiss()
                    
                    return .discarded
                }))
                .padding()
        }
        .listRowInsets(.init(top: 10,
                             leading: 20,
                             bottom: 10,
                             trailing: 20))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.base)
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OnboardView()
        }
    }
}
