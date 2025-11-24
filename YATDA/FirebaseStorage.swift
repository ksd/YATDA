// Firebase.swift
// Project: YATDA
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 07/11/2025 at 10.58.
// Copyright © 2025 ksd. All rights reserved.
//
//

import Foundation
import FirebaseFirestore

class FirebaseStorage: StorageMethod {

    private let dbRef = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    func create<T:Codable>(element: T) throws {
        try dbRef
            .collection("reminders")
            .addDocument(from: element)
    }

    func update<T: Codable & Identifiable>(_ element: T) throws where T.ID == String? {
        guard let documentID = element.id else { return }
        try dbRef
            .collection("reminders")
            .document(documentID)
            .setData(from: element)
    }

    func delete<T:Identifiable>(_ element:T) async throws where T.ID == String? {
        guard let id = element.id else { return }
        try await dbRef
            .collection("reminders")
            .document(id)
            .delete()
    }
}

/// Firebase StorageListner implementation
/// not all db implementations support realtime communication between client & server
/// so in order to ahear to SOLID principle I - Interface Segregation Principle this is done in
/// another protocol and seperated in an extension for readability
extension FirebaseStorage: StorageListner {

    func subscribe<T: Codable>(onChange: @escaping ([T]) -> Void) {
        listenerRegistration = dbRef
            .collection("reminders")
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {return}
                let elements = documents.compactMap { queryDocumentSnapshot in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }
                onChange(elements)
            }
    }

    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
}

