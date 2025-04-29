//
//  SideMenuView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 10/04/23.
//

import SwiftUI
import Combine
struct SideMenuView: View {
    @StateObject private var viewModel = SideMenuViewModel()
    
    var body: some View {
        ZStack(alignment: .trailing) {
            contentView(for: viewModel.current)
            
            if viewModel.showMenu {
                Color.black.opacity(0.59)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.showMenu)
                    .onTapGesture {
                        withAnimation {
                            viewModel.showMenu.toggle()
                        }
                    }
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        
                        List {
                            headerView()
                            
                            ForEach(viewModel.options) { option in
                                cell(for: option)
                                    .onTapGesture {
                                        self.viewModel.current = option
                                        withAnimation {
                                            self.viewModel.showMenu.toggle()
                                        }
                                    }
                            }
                            
                            referView()
                        }
                        .listStyle(.plain)
                        
                    }
                    
                    Spacer()
                    
                    Text(viewModel.version)
                        .foregroundColor(.white)
                        .font(.system(size: 16,
                                      weight: .regular))
                        .opacity(0.4)
                        .padding(.leading, 67)
                }
                .frame(width: 312, alignment: .trailing)
                .background {
                    ZStack(alignment: .top) {
                        Color.textBlack
                            .ignoresSafeArea()
                        
                        Image("menuCurve")
                    }
                    .ignoresSafeArea()
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing),
                                        removal: .move(edge: .leading)))
                .animation(.easeInOut, value: viewModel.showMenu)
            }
        }
        .onReceive(Publishers.menuShowHidePublisher) { output in
            withAnimation {
                viewModel.showMenu = output
            }
        }
    }
    
    private func headerView() -> some View {
        HStack(spacing: 0, content: {
            Spacer()
            
            VStack(alignment: .trailing,
                   spacing: 18) {
                Image("avatar1")
                    .resizable()
                    .frame(width: 75, height: 75)
                
                VStack(spacing: 1) {
                    HStack(alignment: .center, spacing: 10) {
                        Spacer()
                        
                        Text("Allen Camber")
                            .foregroundColor(.textWhite)
                            .font(.system(size: 21, weight: .medium))
                            .frame(height: 25)
                        
                        Image("dropArrow2")
                            .renderingMode(.template)
                            .foregroundColor(.textWhite)
                    }
                    
                    HStack(spacing: 0) {
                        Spacer()
                        Text("@allen007")
                            .foregroundColor(.textWhite)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(0.4)
                            .padding(.trailing, 22)
                    }
                }
            }
        })
               .listRowBackground(Color.clear)
               .listRowSeparator(.hidden)
               .listRowInsets(.init(top: 14, leading: 0, bottom: 14, trailing: 20))
    }
    
    private func cell(for option: SideMenuOption) -> some View {
        HStack(spacing: 15) {
            Spacer()
            
            Text(option.title)
                .foregroundColor(.textWhite)
                .font(.system(size: 18, weight: .medium))
            
            Image(option.iconName)
        }
        .frame(height: 63)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
    }
    
    private func referView() -> some View {
        HStack {
            Spacer()
            
            HStack(spacing: 11) {
                Image("referIcon")
                
                Text("Refer & Earn")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16, weight: .medium))
            }
            .frame(height: 50)
            .padding(.horizontal, 23)
            .background {
                Capsule()
                    .fill(Color.referButtonBg)
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 20, leading: 0, bottom: 0, trailing: 20))
    }
    
    @ViewBuilder
    private func contentView(for option: SideMenuOption) -> some View {
        
        switch option {
        case .home:
            HomeTabView()
        case .profile:
            UserProfileView()
        case .notifications:
            NotificationListView {
                withAnimation {
                    self.viewModel.showMenu.toggle()
                }
            }
        case .bookmarks:
            BookmarkListView()
        case .purchases:
            PurchaseListView()
        case .wallets:
            EmptyView()
        }
        
//        HomeTabView()
    }
}

private extension SideMenuOption {
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "My Profile"
        case .notifications:
            return "Notifications"
        case .bookmarks:
            return "My Bookmarks"
        case .purchases:
            return "My Purchases"
        case .wallets:
            return "My Wallet"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "menuHome"
        case .profile:
            return "menuProfile"
        case .notifications:
            return "menuNotifications"
        case .bookmarks:
            return "menuBookmarks"
        case .purchases:
            return "menuPurchases"
        case .wallets:
            return "menuWallet"
        }
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
