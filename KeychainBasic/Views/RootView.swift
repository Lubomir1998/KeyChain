//
//  RootView.swift
//  KeychainBasic
//
//  Created by Lyubomir Yordanov on 11/16/22.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject public var applicationState: ApplicationState = ApplicationState()
    
    var body: some View {
        
        switch applicationState.appState {
                
            case .loggedIn(let credentials):
                ResourceView(credentials: Credentials(username: credentials.username, password: credentials.password))
                    .environmentObject(applicationState)
                
            case .notLoggedIn:
                LoginView()
                    .environmentObject(applicationState)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
