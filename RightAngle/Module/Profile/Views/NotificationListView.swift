//
//  NotificationListView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 11/04/23.
//

import SwiftUI

struct NotificationListView: View {
    
    let backButtonCallback:()->()
    
    init(backButtonCallback: @escaping () -> Void) {
        self.backButtonCallback = backButtonCallback
    }
    
    var body: some View {
        VStack(spacing: 2) {
            navView()
            
            List {
                cellView(for: .init(with: .init(id: 1, title: "Annette Black",
                                                msg: "Liked your comment",
                                                isRead: false,
                                                time: "2hr ago")))
                
                cellView(for: .init(with: .init(id: 1, title: "Brooklyn",
                                                msg: "Liked your comment",
                                                isRead: false,
                                                time: "2hr ago")))
                
                cellView(for: .init(with: .init(id: 1, title: "Guy Hawkins",
                                                msg: "Liked your comment",
                                                isRead: true,
                                                time: "2hr ago")))
                
                cellView(for: .init(with: .init(id: 1, title: "Ronald Richards",
                                                msg: "Liked your comment",
                                                isRead: true,
                                                time: "2hr ago")))
                
                cellView(for: .init(with: .init(id: 1, title: "Courtney Henry",
                                                msg: "Liked your comment",
                                                isRead: true,
                                                time: "2hr ago")))
            }
            .listStyle(.plain)
            
        }
        .background {
            Color.base
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
    
    private func navView() -> some View {
        VStack(alignment:.leading, spacing:0) {
            HStack {
                Button {
                    self.backButtonCallback()
                } label: {
                    Image("navBack")
                }
                
                Spacer()
            }
            .frame(height: 84)
            
            Text("Notifications")
                .foregroundColor(.navText)
                .font(.system(size: 36,
                              weight: .medium))
                .padding(.top, -14)
        }
        .padding(.horizontal, 20)
    }
    
    private func cellView(for viewModel: NotificationViewModel) -> some View {
        NotificationCellView(viewModel: viewModel)
            .listRowBackground(Color.base)
            .listRowInsets(.init(top: 20,
                                 leading: 20,
                                 bottom: 20,
                                 trailing: 20))
            .listRowSeparator(.hidden, edges: .top)
            .listRowSeparatorTint(.profileSeparator)
    }
}

struct NotificationCellView: View {
    @ObservedObject var viewModel: NotificationViewModel
    
    var body: some View {
        HStack(alignment: .bottom,
               spacing: 10) {
            
            ZStack(alignment: .topLeading) {
                Image("avatar1")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                if !viewModel.notification.isRead {
                    ZStack {
                        Capsule()
                            .fill(Color.notificationBadge)
                            .frame(width: 7, height: 7)
                        
                        Capsule()
                            .stroke(Color.white,
                                    lineWidth: 1)
                            .frame(width: 7, height: 7)
                    }
                        .padding(.top, 5)
                        .padding(.leading, 2)
                }
            }
            
            VStack(alignment: .leading,
                   spacing: 7) {
                Text(viewModel.notification.title)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 18, weight: .medium))
                    .frame(height: 23)
                
                Text(viewModel.notification.msg)
                    .foregroundColor(.textBlack)
                    .font(.system(size: 14, weight: .regular))
                    .frame(height: 23)
                    .opacity(0.5)
            }
            
            Spacer()
            
            Text(viewModel.notification.time)
                .foregroundColor(.textBlack)
                .font(.system(size: 14, weight: .regular))
                .frame(height: 23)
                .opacity(0.5)
        }
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView {
            
        }
    }
}
