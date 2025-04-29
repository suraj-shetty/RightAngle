//
//  HomeListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/02/23.
//

import SwiftUI
import PartialSheet

struct HomeListView: View {
    @StateObject var viewModel = HomeListViewModel()
    @State private var showProfiles: Bool = false
    @State private var manageProfiles: Bool = false
    @State private var loadNotifications: Bool = false
    
    var body: some View {
        NavigationView(content: {
            VStack(alignment: .center, spacing: 20) {
                navView()
                .frame(height: 60)
                
                ZStack(alignment: .top) {
                    ForEach( Array(viewModel.items.enumerated()), id: \.offset) { index, element in
                        NavigationLink(destination: {
                            CurriculumView(viewModel: element)
                        }, label: {
                            rowView(for: element)
                        })
                            .id(index)
                            .offset(x: 0,
                                    y: CGFloat(index) * 135)
                    }
                }
            }
            .background {
                Color.base
                    .ignoresSafeArea()
            }
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showProfiles,
               onDismiss: {
            self.showProfiles = false
        }, content: {
            NavigationView {
                AccountListView(onManageProfile: {
                    self.showProfiles.toggle()
                    self.manageProfiles.toggle()
                })
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .background {
                        Color.base
                            .ignoresSafeArea(.all, edges: .bottom)
                            .offset(y:20)
                    }
            }
        })
        .presentationDetents([.medium])
        
//        .partialSheet(isPresented: $showProfiles,
//                      iPhoneStyle: .init(background: .solid(.clear),
//                                                                     
//                                         handleBarStyle: .solid(.paleGrey4),
//                                         cover: .enabled(.black.opacity(0.59)),
//                                         cornerRadius: 20))
//        {
//            AccountListView(onManageProfile: {
//                self.showProfiles.toggle()
//                self.manageProfiles.toggle()
//            })
//                .cornerRadius(20, corners: [.topLeft, .topRight])
//                .background {
//                    Color.base
//                        .ignoresSafeArea(.all, edges: .bottom)
//                        .offset(y:20)
//                }
//        }
        .fullScreenCover(isPresented: $manageProfiles) {
            ManageProfilesView()
        }
        .fullScreenCover(isPresented: $loadNotifications) {
            NotificationListView {
                self.loadNotifications.toggle()
            }
        }
    }
    
    private func rowView(for row: HomeRowViewModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Image(row.type.icon)
                    .frame(width: 50, height: 50)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 3) {
                        Text("View All")
                            .foregroundColor(.textBlack)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Image("viewAction")
                    }
                }
            }
            
            HStack(alignment: .center) {
                Text(row.type.title)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 19, weight: .medium))
                
                Spacer()
                
                Text(row.subTitle)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 18, weight: .regular))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .frame(maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(row.type.color)
                .cornerRadius(40,
                              corners: [.topLeft, .topRight])
        }
    }
    
    private func navView() -> some View {
        HStack(alignment: .top, spacing: 11) {
            Image("Ellipse 2")
            
            VStack(alignment:.leading ,spacing: 0) {
                HStack(alignment: .center, spacing: 9) {
                    Text("Allen Camber")
                        .foregroundColor(.textBlack)
                        .font(.system(size: 25,
                                      weight: .medium))
                        .frame(height: 30)
                    
                    Image("dropArrow2")
                }
                
                Text("Grade 6 - ICSE")
                    .foregroundColor(.textBlack)
                    .font(.system(size: 16, weight: .regular))
                    .opacity(0.5)
                
            }
            
            Spacer()
            
            Button {
                self.loadNotifications.toggle()
            } label: {
                Image("notificationHome")
            }

        }
        .padding(.horizontal, 20)
        .onTapGesture {
            self.showProfiles.toggle()
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
