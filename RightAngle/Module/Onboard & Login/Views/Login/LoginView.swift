//
//  LoginView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 29/01/23.
//

import SwiftUI
import Combine

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocussed :Bool
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    
    @State private var onboard: Bool = false
    @State private var showSocialLogin: Bool = true
    @State private var loadCountryPicker: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: OnboardView(),
                           isActive: $onboard) {
                EmptyView()
            }
//            NavigationLink(destination: HomeTabView(),
//                           isActive: $viewModel.didLogin) {
//                EmptyView()
//            }
            
            VStack(spacing:0) {
                ZStack {
                    HStack {
                        NavBackButton(dismiss: self.dismiss)
                            .frame(height: 70)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Spacer()
                        
                        Text("Login")
                            .foregroundColor(.navText)
                            .font(.system(size: 25,
                                          weight: .medium))
                        
                        Spacer()
                    }
                }
                .background {
                    Color.base
                        .ignoresSafeArea(.all,
                                         edges: .top)
                }
                                
                HStack(spacing: 10) {
                    if viewModel.isMobileNumber {
                        countryView()
                            .transition(.slide)
                            .animation(.default, value: viewModel.isMobileNumber)
                            .sheet(isPresented: $loadCountryPicker, content: {
                                CountryPickerViewProxy { choosenCountry in
                                    let code = choosenCountry.countryCode
                                    self.viewModel.switchCountry(with: code)
                                }
                            })
                            .presentationDetents([.large])
                            .onTapGesture {
                                self.loadCountryPicker = true
                            }
                    }
                    
                    TextField(text: $viewModel.input) {
                        Text("Enter address or phone number")
                            .foregroundColor(.textBlack.opacity(0.54))
                            .font(.system(size: 16, weight: .regular))
                    }
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16, weight: .regular))
                    .tint(.textBlack)
                    .focused($isFocussed)
                    .keyboardType(.emailAddress)
        //            .textCase(.lowercase)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .onSubmit {
                        isFocussed.toggle()
                    }
                }
                .inputField(with: "Enter address or phone number")
                
                socialLoginView()
                    .opacity(showSocialLogin ? 1.0 : 0.0)
                
                Button {
                    Task.detached {
                        await viewModel.login()
                    }
//                    self.didLogin = true
                } label: {
                    Text("Login")
                }
                .buttonStyle(SubmitButtonStyle())
                .disabled(!viewModel.canSubmit)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
            if viewModel.captureOTP {
                Color.black
                    .opacity(0.59)
                    .padding(.horizontal, -20)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.captureOTP)
                    
                
                PinInputView(viewModel: viewModel)
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    .padding(.horizontal, -20)
                    .background(content: {
                        Color.base
                            .padding(.horizontal, -20)
                            .ignoresSafeArea(.all, edges: .bottom)
                            .offset(y: 40)
                    })
                    .animation(.easeInOut, value: viewModel.captureOTP)
                    .transition(.move(edge: .bottom))
//                    .ignoresSafeArea(.all, edges: .bottom)
            }
        }
        .padding(.horizontal, 20)
//        .padding(.top, 10)
        .background {
            Color.base
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                NavBackButton(dismiss: self.dismiss)
//            }
//
//            ToolbarItem(placement: .principal) {
//                Text("Login")
//                    .foregroundColor(.navText)
//                    .font(.system(size: 25,
//                                  weight: .medium))
//            }
//
////            ToolbarItem(placement: .keyboard) {
////                VStack {
////                    Spacer()
////                    Button {
////                        self.isFocussed = false
////                    } label: {
////                        Text("Done")
////                            .foregroundColor(.white)
////                    }
////
////                }
////            }
//        }
        .onReceive(Publishers.keyboardPublisher) { output in
            self.showSocialLogin = !output
        }
        .onChange(of: viewModel.loading) { newValue in
            if newValue == true {
                AlertUtility.showHUD()
            }
            else {
                AlertUtility.hidHUD()
            }
        }
    }
    
    private func socialLoginView() -> some View {
        VStack(spacing: 0) {
            ZStack {
                Divider()
                    .background(content: {
                        Color.seperator
                    })
                    .frame(height: 1)
             
                Text("OR")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16, weight: .medium))
                    .opacity(0.45)
                    .padding(.horizontal, 6)
                    .background {
                        Color.background
                    }
            }
            .padding(.bottom, 16)
            
            VStack(spacing: 18) {
                Button {
                    viewModel.googleLogin()
                } label: {
                    HStack(alignment: .center, spacing: 35) {
                        Image("googleLogo")
                        Text("Connect with Google")
                        Spacer()
                    }
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button {
                    viewModel.appleLogin()
                } label: {
                    HStack(alignment: .center, spacing: 35) {
                        Image("appleLogo")
                        Text("Connect with Apple")
                        Spacer()
                    }
                }
                .buttonStyle(BorderedButtonStyle())
            }
            
            Spacer()
            
            Text("Don't you have an account? [Sign Up](open://viewSignUp)")
                .font(.system(size: 16,
                              weight: .semibold))
                .foregroundColor(.infoText)
                .tint(.infoHighlight)
                .environment(\.openURL, OpenURLAction(handler: { _ in
                    self.onboard.toggle()
                    return .discarded
                }))
        }
        .padding(.top, 15)
        .padding(.bottom, 30)
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
                    .cornerRadius(3)
                
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
