//
//  ApplicationState.swift
//  KeychainBasic
//
//  Created by Lyubomir Yordanov on 11/16/22.
//

import Foundation

class ApplicationState: ObservableObject {
    
    enum State {
        case loggedIn(Credentials)
        case notLoggedIn
    }
    
    @Published var appState: State = .notLoggedIn
    
    init() {
        
        self.appState = get() == nil ? .notLoggedIn : .loggedIn(Credentials(username: get()!.0, password: get()!.1))
    }
}
