//
//  ReelsPageView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 09/03/23.
//

import SwiftUI

struct ReelsPageView: View {
    @ObservedObject var viewModel: ReelViewModel
    var contentInset: EdgeInsets = .init()
    @State private var expandText: Bool = true
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()
            
            Image(systemName: "photo")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.textWhite.opacity(0.6))
                .frame(width: 80)
            
            HStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 9) {
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 9) {
                        Image("Ellipse 2")
                            .frame(width: 40, height: 40)
                            .clipShape(Capsule())
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Kunal Sharma")
                                .foregroundColor(.textWhite)
                                .font(.system(size: 16, weight: .medium))
                                .lineSpacing(7)
                            
                            Text("views.count".countString(value: 12000))
                                .foregroundColor(.textWhite)
                                .font(.system(size: 12, weight: .medium))
                                .opacity(0.6)
                        }
                        
                        Spacer()
                    }
                    
                    ExpandableText(text: viewModel.title,
                                   expand: $expandText) { _ in
                        
                    }
                                   .foregroundColor(.textWhite)
                                   .font(.systemFont(ofSize: 14, weight: .medium))
                                   .lineLimit(3)
                }
                
                VStack(alignment: .center, spacing: 24) {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        VStack(spacing: 7) {
                            Image("likeWhite")
                            
                            Text("240")
                                .foregroundColor(.textWhite)
                                .font(.system(size: 12, weight: .medium))
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        VStack(spacing: 7) {
                            Image("commentWhite")
                            
                            Text("240")
                                .foregroundColor(.textWhite)
                                .font(.system(size: 12, weight: .medium))
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        VStack(spacing: 7) {
                            Image("bookmarkWhite")
                            
                            Text("30")
                                .foregroundColor(.textWhite)
                                .font(.system(size: 12, weight: .medium))
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        VStack(spacing: 7) {
                            Image("shareWhite")
                            
                            Text("98")
                                .foregroundColor(.textWhite)
                                .font(.system(size: 12, weight: .medium))
                        }
                    }

                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 14)
            .padding(.bottom, contentInset.bottom)
//            .padding(.top, contentInset.top)
            

        }
    }
}

struct ReelsPageView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsPageView(viewModel: .init(title: "Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos"))
    }
}
