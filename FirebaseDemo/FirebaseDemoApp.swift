//
//  FirebaseDemoApp.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 25/10/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct FirebaseDemoApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        let firebaseAuthController = FirebaseAuthController()
        WindowGroup {
            Group {
                if firebaseAuthController.getUser() != nil {
                    ContentView()
                } else {
                    Login()
                }
            }
            .environment(UserController())
            .environment(FirebaseAuthController())
        }
    }
}
