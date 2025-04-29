//
//  PinInputView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 05/04/23.
//

import SwiftUI
import SwiftDate

struct PinInputView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocussed: Bool
    
    @ObservedObject var viewModel: LoginViewModel
    @State private var pin: String = ""
    
    var body: some View {
        VStack(spacing:0) {
            navView()
            
            Text("Please enter the OTP received on your registered mobile number")
                .foregroundColor(.textBlack)
                .font(.system(size: 12, weight: .regular))
                .lineSpacing(6)
                .opacity(0.5)
                .multilineTextAlignment(.center)
                .frame(width: 242)
            
            Color.clear
                .frame(height: 30)
            
            PinView(otpCode: $viewModel.otp, otpCodeLength: 4)
                .focused($isFocussed)
                .onChange(of: viewModel.otp) { newValue in
                    if newValue.count == 4 {
                        self.isFocussed = false
                    }
                }
                .onTapGesture {
                    self.isFocussed = true
                }
            
            Spacer()
            
            switch viewModel.otpStatus {
            case .duration(let interval):
                Text(
                    interval.toString {
                        $0.maximumUnitCount = 2
                        $0.allowedUnits = [.minute, .second]
                        $0.collapsesLargestUnit = false
                        $0.unitsStyle = .positional
                        $0.zeroFormattingBehavior = .pad
                    }
                )
                .foregroundColor(.textBlack)
                .font(.system(size: 16, weight: .regular))
                .padding(.bottom, 25)
                
            default: EmptyView()
            }
            
            
            Button {
                Task.detached {
                    await viewModel.login()
                }
            } label: {
                Text("Send me a new code")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 18, weight: .medium))
                    .underline()
            }
            .frame(height: 60)
            .disabled(!viewModel.allowPinRequest)
            .opacity(viewModel.allowPinRequest ? 1.0 : 0.5)
            
            Button {
                Task.detached {
                    await self.viewModel.verifyPin()
                }
            } label: {
                Text("VERIFY")
            }
            .buttonStyle(SubmitButtonStyle())
            .disabled(viewModel.otp.count < 4)
            .opacity(viewModel.otp.count < 4 ? 0.5 : 1.0)
            .padding(.horizontal, 20)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button {
                    self.isFocussed = false
                } label: {
                    Text("Done")
                        .foregroundColor(.textWhite)
                        .font(.system(size: 15, weight: .regular))
                }
            }
        }
        .background {
            Color.base
//                .ignoresSafeArea(.all, edges: .bottom)
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
    
    private func navView() -> some View {
        HStack(alignment: .center) {
            Color.clear
                .frame(width: 64, height: 64)
                                    
            Spacer()
            
            Text("Enter OTP")
                .foregroundColor(.textBlack)
                .font(.system(size: 18, weight: .medium))
            
            Spacer()
            
            Button {
                self.isFocussed = false
                withAnimation {
                    viewModel.captureOTP.toggle()
                }
//                dismiss()
            } label: {
                Image("navClose")
            }
            .frame(width: 64, height: 64)
        }
    }
}

struct PinInputView_Previews: PreviewProvider {
    static var previews: some View {
        PinInputView(viewModel: LoginViewModel())
    }
}
