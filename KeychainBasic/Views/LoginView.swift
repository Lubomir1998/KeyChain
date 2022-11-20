//
//  LoginView.swift
//  KeychainBasic
//
//  Created by Lyubomir Yordanov on 11/16/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var applicationState: ApplicationState
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var error: Error? = nil
    
    @State private var success: Bool = false
        
    var body: some View {
        
        let errorBinding = Binding<Bool>(get: { error != nil }, set: { _ in })
        
        VStack(spacing: 25) {
            
            TextField("Username", text: $username)
                .font(.system(size: 24))
            
            TextField("Password", text: $password)
                .font(.system(size: 24))
            
            Button {
                do {
                    try save(credentials: Credentials(username: username, password: password))
//                    self.success = true
                    self.applicationState.appState = .loggedIn(Credentials(username: username, password: password))
                }
                catch {
                    self.error = error
                }
            } label: {
                Text("Login")
                    .font(.system(size: 29))
            }
            .disabled(username.isEmpty || password.isEmpty)
            
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
            
            VStack {EmptyView()}
                .alert(isPresented: $success) {
                    Alert(
                        title: Text("Added"),
                        dismissButton: .default(Text("Ok"))
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
