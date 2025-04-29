//
//  ManageProfilesView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/04/23.
//

import SwiftUI

struct ManageProfilesView: View {
    @StateObject private var listViewModel = AccountListViewModel()
    @State private var contentHeight: CGFloat = 0
    @State private var addAccount: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0, content: {
                GeometryReader { proxy in
                    let tileWidth =  floor((proxy.size.width - 15)/2.0)
                    let tileHeight = tileWidth * 0.92
                    let columns = Array<GridItem>(repeating: GridItem(.flexible(), spacing: 15),
                                                  count: 2)

                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(listViewModel.list, id:\.name) { info in
                            ZStack(alignment: .topTrailing) {
                                AccountInfoView(info: AccountInfoViewModel(info: info))
                                    .frame(width: tileWidth, height: tileHeight)
                                    .background(content: {
                                        AccountTileBackgroundView()
                                    })
                                
                                Button {
                                    
                                } label: {
                                    Image("tileClose")
                                }
                                .padding(.top, 12)
                                .padding(.trailing, 12)
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
//                .frame(height: contentHeight)
                .padding(.top, 38)
                
                Spacer()
                
                Button {
                    self.dismiss()
                } label: {
                    Text("Save & Update")
                }
                .buttonStyle(SubmitButtonStyle())
            })
            .padding(.horizontal, 20)
            .background(content: {
                Color.base
                    .ignoresSafeArea()
            })
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Manage Profiles")
                        .foregroundColor(.navText)
                        .font(.system(size: 25,
                                      weight: .medium))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.dismiss()
                    } label: {
                        Image("navClose")
                    }

                }
            }
        }
        .fullScreenCover(isPresented: $addAccount) {
            NavigationView {
                AddAccountView(mode: .addChild)
            }
        }
    }
}

struct ManageProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfilesView()
    }
}
