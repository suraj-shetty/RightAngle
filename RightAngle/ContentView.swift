//
//  ContentView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 27/01/23.
//

import SwiftUI
import PartialSheet
import Combine

struct ContentView: View {
    @State private var didLogIn: Bool = false
    
    var body: some View {
        ZStack {
            TeacherProfileView()
//            if didLogIn {
//                SideMenuView()
////                    .attachPartialSheetToRoot()
//                    .transition(.asymmetric(insertion: .move(edge: .trailing),
//                                            removal: .move(edge: .leading)))
//                    .animation(.easeInOut, value: didLogIn)
//            }
//            else {
//                IntroView()
//                    .transition(.asymmetric(insertion: .move(edge: .trailing),
//                                            removal: .move(edge: .leading)))
//                    .animation(.easeInOut, value: didLogIn)
//            }
        }
        .attachPartialSheetToRoot()
        .background {
            Color.base
                .ignoresSafeArea()
        }
        .onReceive(Publishers.loggedInOutPublisher) { output in
            withAnimation {
                self.didLogIn = output
            }
        }
        .onAppear {
            if let token = SGUserDefaultStorage.getToken(), !token.isEmpty {
                self.didLogIn = true
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
