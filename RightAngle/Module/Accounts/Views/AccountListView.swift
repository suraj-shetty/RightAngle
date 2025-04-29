//
//  AccountListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/04/23.
//

import SwiftUI

struct AccountListView: View {
    @StateObject private var listViewModel = AccountListViewModel()
    @State private var contentHeight: CGFloat = 0
    @State private var addAccount: Bool = false
    private let callBack:()->()
    
    init(onManageProfile: @escaping ()->()) {
        self.callBack = onManageProfile
    }
    
    
    var body: some View {
        VStack(spacing:21) {
            Text("Profiles")
                .foregroundColor(.textBlack)
                .opacity(0.5)
                .font(.system(size: 14, weight: .medium))
                .padding(.top, 30)
            
            GeometryReader { proxy in
                let tileWidth =  floor((proxy.size.width - 15)/2.0)
                let tileHeight = tileWidth * 0.92
                let columns = Array<GridItem>(repeating: GridItem(.flexible(), spacing: 15),
                                              count: 2)

                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(listViewModel.list, id:\.name) { info in
                        AccountInfoView(info: AccountInfoViewModel(info: info))
                            .frame(width: tileWidth, height: tileHeight)
                            .background(content: {
                                AccountTileBackgroundView()
                            })
                            .onTapGesture {
                            }
                    }

                    let remaining = 4 - listViewModel.list.count
                    if remaining > 0 {
                        ForEach(0..<remaining, id: \.self) { index in
                            EmptyAccountInfoView()
                                .frame(width: tileWidth, height: tileHeight)
                                .background(content: {
                                    AccountTileBackgroundView()
                                })
                                .onTapGesture {
                                    self.addAccount.toggle()
                                }
                        }
                    }
                }
                .onAppear {
                    self.contentHeight = tileHeight * 2 + 15.0
                }
            }
            .frame(height: contentHeight)
            .padding(.horizontal, 20)
            
            Button {
                self.callBack()
            } label: {
                HStack(spacing: 7) {
                    Image("pencil")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundColor(.textBlack)
                    
                    Text("Manage Profiles")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.textBlack)
                        
                }
                .padding(.vertical, 10)
            }
            .padding(.top, 13)
        }
        .background {
            Color.base
        }
        .onAppear {
            listViewModel.list = [ AccountInfo(name: "Allen Camber",
                                               grade: "GRADE 6",
                                               board: "ICSE",
                                               avatar: "avatar1"),
                                   ]
        }
        .fullScreenCover(isPresented: $addAccount,
                         onDismiss: {
            self.addAccount = false
        }, content: {
            NavigationView {
                AddAccountView(mode: .addChild)
            }
            .attachPartialSheetToRoot()
        })
//        .fullScreenCover(isPresented: $addAccount) {
//            NavigationView {
//                AddAccountView(mode: .addChild)
//            }
//        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AccountListView {
                
            }
        }
        .background {
            Color.red
        }
    }
}
