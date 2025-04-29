//
//  IntroView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 28/01/23.
//

import SwiftUI

struct IntroView: View {
    @State private var goToLogin: Bool = false
    @State private var onboard: Bool = false
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                NavigationLink(destination: LoginView(),
                               isActive: $goToLogin) {
                    EmptyView()
                }
                
                NavigationLink(destination: OnboardView(),
                               isActive: $onboard) {
                    EmptyView()
                }
                
//                NavigationLink(destination: HomeTabView(),
//                               isActive: $viewModel.didLogin) {
//                    EmptyView()
//                }
                
//                VStack {
//                    Image("onboard")
//                        .offset(x: 0, y: -44)
//                    Spacer()
//                }
                
                VStack(alignment: .center, spacing: 0) {
                    
                    HStack {
                     Image("onboardLogo")
                        
                        Text("Right Angle")
                            .foregroundColor(.navText)
                            .font(.system(size: 26,
                                          weight: .semibold))
                    }
                        .padding(.top, 22)
                    
                    Image("onboard")
                        .resizable()
                        .padding(EdgeInsets(top: 40,
                                            leading: 39,
                                            bottom: 36,
                                            trailing: 39))
                    
                    VStack(spacing: 24) {
                        VStack(spacing: 18) {
                            Button {
                                viewModel.googleLogin()
                            } label: {
                                HStack(alignment: .center, spacing: 35) {
                                    Image("googleLogo")
                                    Text("Connect with Google")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.6)
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
                        
                        Button {
                            self.goToLogin.toggle()
                        } label: {
                            HStack(spacing: 6) {
                                Spacer()
                                
                                Image("mailIcon")
                                
                                Text("Login with email & phone")
                                
                                Spacer()
                            }
                        }
                        .buttonStyle(SubmitButtonStyle())
                        
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
                    .padding(.horizontal, 20)
                }
            }
            .background {
                Color.base
                    .ignoresSafeArea()
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
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
