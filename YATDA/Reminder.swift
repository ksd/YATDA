// Reminder.swift
// Project: YATDA
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.24.
// Copyright © 2025 ksd. All rights reserved.
//
//


import Foundation
import FirebaseFirestore

struct Reminder: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var isCompleted = false
}

extension Reminder {
    static let samples = [
        Reminder(id: "1", title: "Build sample app", isCompleted: true),
        Reminder(id: "2", title: "Create tutorial"),
        Reminder(id: "3", title: "Praise swift", isCompleted: true),
        Reminder(id: "4", title: "Graduate from Swift Bootcamp"),
    ]
}

struct DemoUser: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let gender: String
}
