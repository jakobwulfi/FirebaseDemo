//
//  FirebaseAuthController.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 13/11/2024.
//

import FirebaseAuth
import SwiftUI

@Observable
class FirebaseAuthController: ObservableObject {
    var isSignedIn: Bool = false
    var errorMessage: String?
    var authUser: FirebaseAuth.User?
    
    init() {
        self.isSignedIn = Auth.auth().currentUser != nil
    }
    
    func getUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String) async {
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let authUser = authDataResult.user
            print("Signed in as user \(authUser.uid), with email: \(authUser.email ?? "")")
            Task(priority: .high) {
                self.isSignedIn = true
            }
            
        }
        catch {
            print("There was an issue when trying to sign in: \(error)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            authUser = nil
        } catch {
            print("Failed to sign out: \(error)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    func signUp(email: String, password: String) async {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let authUser = authDataResult.user
            print("Signed up as user \(authUser.uid), with email: \(authUser.email ?? "")")
            Task(priority: .high) {
                self.isSignedIn = true
            }
        } catch {
            print("There was an issue when trying to sign up: \(error)")
            self.errorMessage = error.localizedDescription
        }
    }
    
}
