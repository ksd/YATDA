// AuthController.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 24/11/2025 at 09.35.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticated
    case authenticating
}

@Observable
class AuthController {

    var authenticationState: AuthenticationState = .unauthenticated
    var user: User?
    var displayName = ""
    @ObservationIgnored
    var authStateHandler: AuthStateDidChangeListenerHandle?

    init(){
        registerAuthStateHandler()
    }

    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { (auth, user) in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.displayName ?? "Anonymous"
            }
        }
    }

    func signInWithEmailPassword(email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            print("Error signing in: \(error.localizedDescription)")
        }
    }

    func signUpWithEmailPassword(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            print("Error signing up: \(error.localizedDescription)")
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func deleteAccount() async {
        do {
            try await user?.delete()
        } catch {
            print("Error Deleting Account: \(error.localizedDescription)")
        }
    }

}
