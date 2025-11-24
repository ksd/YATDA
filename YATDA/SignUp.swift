// SignUp.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 24/11/2025 at 11.57.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI

struct SignUp: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @Environment(AuthController.self) var authController

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .keyboardType(.default)
            }
            Section {
                Button( action: {
                    Task{
                        await authController.signUpWithEmailPassword(
                            email: emailAddress,
                            password: password)
                    }
                },
                        label: {
                    Text("Sign Up")
                        .bold()
                })
            }
        }.navigationTitle("Sign Up")
    }
}

#Preview {
    SignUp().environment(AuthController())
}
