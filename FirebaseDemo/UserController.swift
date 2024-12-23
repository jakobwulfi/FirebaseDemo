//
//  UserController.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 25/10/2024.
//

import SwiftUI

@Observable
class UserController: ObservableObject {
    var users = [User]()
    var foundUsers = [User]()
    
    @ObservationIgnored
    private var firebaseService = FirebaseService()
    
    init() {
        firebaseService.setUpListener { fetchedUsers in
            self.users = fetchedUsers
        }
    }
    
    func update(user: User) {
        firebaseService.addUser(user: user)
    }
    
    func delete(user: User) {
        firebaseService.deleteUser(user: user)
    }
    
    func add(user: User) {
        firebaseService.addUser(user: user)
    }
    
    func getUsers(gender: String) -> [User] {
        Task(priority: .low) {
            self.foundUsers = await firebaseService.getUsers(gender: gender)
        }
        return foundUsers
    }
}
