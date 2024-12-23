//
//  ContentView.swift
//  FirebaseDemo
//
//  Created by dmu mac 31 on 25/10/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(UserController.self) private var userController
    @Environment(FirebaseAuthController.self) private var authController
    @State private var isMaleSheetPresented = false
    @State private var isFemaleSheetPresented = false	
    
    var body: some View {
        @State var isSignedIn = authController.isSignedIn
            NavigationStack {
                List {
                    ForEach(userController.users) { user in
                        HStack {
                            Text(user.name)
                                .font(.headline)
                            Text(user.id ?? "")
                                .font(.footnote)
                                .fontWeight(.thin)
                                .foregroundStyle(.gray)
                            Text(user.gender.rawValue)
                        }
                    }
                    .onDelete { indexSet in
                        let user = userController.users[indexSet.first!]
                        userController.delete(user: user)
                    }
                    Button("Add User") {
                        userController.add(user: User(name: "William", birthdate: Date.now, gender: User.Genders(rawValue: "male")!))
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Sign Out") {
                            authController.signOut()
                        }
                    }
                }
                

                // HStack for the Males and Females tabs/buttons
                HStack {
                    Button("Males") {
                        isMaleSheetPresented.toggle()
                    }
                    .sheet(isPresented: $isMaleSheetPresented) {
                        VStack {
                            Text("Males")
                                .font(.headline)
                                .padding()
                            List {
                                ForEach(userController.getUsers(gender: "male")) { user in
                                    HStack {
                                        Text(user.name)
                                            .font(.headline)
                                        Text(user.id ?? "")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundStyle(.gray)
                                        Text(user.gender.rawValue)
                                    }
                                }
                            }
                            Button("Close") {
                                isMaleSheetPresented = false
                            }
                            .padding()
                        }
                    }

                    Button("Females") {
                        isFemaleSheetPresented.toggle()
                    }
                    .sheet(isPresented: $isFemaleSheetPresented) {
                        VStack {
                            Text("Females")
                                .font(.headline)
                                .padding()
                            List {
                                ForEach(userController.getUsers(gender: "female")) { user in
                                    HStack {
                                        Text(user.name)
                                            .font(.headline)
                                        Text(user.id ?? "")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundStyle(.gray)
                                        Text(user.gender.rawValue)
                                    }
                                }
                            }
                            Button("Close") {
                                isFemaleSheetPresented = false			
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigate(to: Login(), when: not($isSignedIn) )
        }
    }

func not(_ value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

#Preview {
    ContentView()
        .environment(UserController())
        .environment(FirebaseAuthController())
}
