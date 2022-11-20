//
//  ContentView.swift
//  KeychainBasic
//
//  Created by Lyubomir Yordanov on 11/16/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public struct Credentials {
    
    let username: String
    let password: String
}
