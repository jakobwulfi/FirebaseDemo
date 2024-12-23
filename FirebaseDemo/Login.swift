//
//  Login.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 13/11/2024.
//

import SwiftUI
import FirebaseAuth

struct Login: View {
    @Environment(FirebaseAuthController.self) private var authController
    @Environment(UserController.self) private var userController

    @State var email = ""
    @State var password = ""
    var body: some View {
        @State var isSignedIn = authController.isSignedIn
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: {
                Task {
                    await authController.signIn(email: email, password: password)
                }
            }) {
                Text("Sign in")
            }
        }
        .padding()
        .navigate(to: ContentView(), when: $isSignedIn)
    }
    
}
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}




#Preview {
    Login().environment(FirebaseAuthController())
}
