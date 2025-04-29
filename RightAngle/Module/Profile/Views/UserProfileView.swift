//
//  UserProfileView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 11/04/23.
//

import SwiftUI

struct UserProfileView: View {
    @State private var editProfile: Bool = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView()
                
                Group {
                    NavigationLink {
                        WatchHistoryView()
                    } label: {
                        HStack(spacing: 14) {
                            Image("watchHistory")
                            
                            Text("My Watch History")
                                .foregroundColor(.textBlack)
                                .font(.system(size: 16,
                                              weight: .medium))
                            
                            Spacer()
                            
                            Image("disclosure")
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.top, 10)
                    
                    Divider()
                        .background {
                            Color.profileSeparator
                        }

                    NavigationLink {
                        EmptyView()
                    } label: {
                        HStack(spacing: 14) {
                            Image("settingsWheel")
                            
                            Text("Settings")
                                .foregroundColor(.textBlack)
                                .font(.system(size: 16,
                                              weight: .medium))
                            
                            Spacer()
                            
                            Image("disclosure")
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.top, 10)
                }
                .padding(.horizontal, 20)
                                
                Spacer()
                
                Button {
                    NotificationCenter.default.post(name: .loggedOut,
                                                    object: nil)
                } label: {
                    HStack {
                        Text("Logout")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.textBlack)
                            
                        Spacer()
                        
                        Image("logout")
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 70)
                }
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pinBackground)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
            }
            .background {
                Color.base
                    .ignoresSafeArea()
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $editProfile) {
                NavigationView {
                    AddAccountView(mode: .edit)
                }
            }
        }
    }
    
    private func headerView() -> some View {
            VStack(alignment: .center, spacing: 0) {
                navView()
                
                Image("avatar1")
                    .resizable()
                    .frame(width: 96, height: 96)
                
                Text("Allen Camber")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 19, weight: .medium))
                    .frame(height: 23)
                    .padding(.top, 8)
                
                Text("Grade 6, ICSE")
                    .foregroundColor(.black.opacity(0.5))
                    .font(.system(size: 12, weight: .medium))
                    .frame(height: 23)
                
                Button {
                    self.editProfile.toggle()
                } label: {
                    HStack(spacing: 5) {
                        Image("pencil")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .aspectRatio(contentMode: .fit)
                        
                        Text("Edit Profile")
                            .foregroundColor(.textWhite)
                            .font(.system(size: 16, weight: .medium))
                            .frame(height: 19)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background {
                        Capsule()
                            .fill(Color.textBlack)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
        .background {
            ZStack(alignment: .topTrailing) {
                Color.curriculumHeader
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                
                Image("profileCurve")
                    .padding(.top, 30)
            }
            .ignoresSafeArea()
        }
    }
    
    private func navView() -> some View {
        ZStack {
            HStack {
                Button {
                    NotificationCenter.default.post(name: .menuShow, object: nil)
                } label: {
                    Image("navBack")
                }

                
                Spacer()
            }
            
            Text("My Profile")
                .foregroundColor(.navText)
                .font(.system(size: 25,
                              weight: .medium))
            
        }
        .frame(height: 84)
        .padding(.horizontal, 20)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
