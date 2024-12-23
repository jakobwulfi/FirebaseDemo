//
//  UserModel.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 25/10/2024.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let birthdate: Date
    let gender: Genders
    
    
    enum Genders: String, Codable {
        case male, female, other
    }
    
    // Computed property for formatted birthdate
    //var formattedBirthdate: String {
    //    let formatter = DateFormatter()
    //    formatter.dateStyle = .medium // Customize the style (short, medium, long, full) as needed
    //    return formatter.string(from: birthdate)
   // }
}
