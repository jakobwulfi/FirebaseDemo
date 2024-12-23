//
//  FirebaseService.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 25/10/2024.
//

import Foundation
import FirebaseFirestore

struct FirebaseService {
    private let dbCollection = Firestore.firestore().collection("users")
    private var listener: ListenerRegistration?
    
    mutating func setUpListener(callback: @escaping ([User]) -> Void) {
        listener = dbCollection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            let users = documents.compactMap{ queryDocumentSnapshot -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            callback(users.sorted{ $0.name < $1.name})
        }
    }
    
    func getUsers(gender: String) async -> [User] {
        do {
            let query = try await dbCollection
                .whereField("gender", isEqualTo: gender)
                .getDocuments()
            let sortedUsers = query.documents.compactMap { queryDocumentSnapshot -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            return sortedUsers
        } catch {
            print("Error getting documents: \(error)")
            return []  // Return an empty array in case of an error
            }
    }
    
    mutating func tearDownListener() {
        listener?.remove()
        listener = nil
    }
    
    func addUser(user: User) {
        do {
            let _ = try dbCollection.addDocument(from: user.self)
        } catch {
            print(error)
        }
    }
    
    func deleteUser(user: User) {
        guard let documentID = user.id else { return }
        dbCollection.document(documentID).delete() { error in
            if let error {
                print(error)
            }
        }
    }
}
