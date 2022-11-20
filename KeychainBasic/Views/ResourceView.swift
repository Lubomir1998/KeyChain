//
//  ResourceView.swift
//  KeychainBasic
//
//  Created by Lyubomir Yordanov on 11/16/22.
//

import SwiftUI

struct ResourceView: View {
    
    let credentials: Credentials
    
    @EnvironmentObject var applicationState: ApplicationState
    @State private var error: Error? = nil
        
    var body: some View {
        
        let errorBinding = Binding<Bool>(get: { error != nil }, set: { _ in })
        
        VStack(spacing: 25) {
            
            Text(credentials.username)
                .font(.system(size: 24))
            
            Text(credentials.password)
                .font(.system(size: 24))
            
            Button {
                do {
                 
                    try remove(username: credentials.username)
                    self.applicationState.appState = .notLoggedIn
                }
                catch {
                    self.error = error
                }
            } label: {
                Text("Logout")
                    .font(.system(size: 25))
            }
            
            VStack {EmptyView()}
                .alert(isPresented: errorBinding) {
                    Alert(
                        title: Text("Error hapened"),
                        message: Text(error?.localizedDescription ?? "something is wrong"),
                        dismissButton: .default(Text("Ok")) {
                            error = nil
                        }
                    )
                }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .padding()
    }
}

struct ResourceView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceView(
            credentials: Credentials(username: "pesho", password: "12345")
        )
    }
}
