// StorageMethod.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 07/11/2025 at 10.53.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import Foundation

/// StorageMethod
/// Implementering af Dependency Inversion Principle i SOLID &
/// Interface Segregation Principle fra SOLID
protocol StorageMethod {
    func create<T: Codable & Identifiable>(element: T) throws
    //func retrieve<T: Codable & Identifiable>(_ id: T.ID) throws -> T? where T.ID == String?
    func update<T: Codable & Identifiable>(_ element: T) throws where T.ID == String?
    func delete<T: Identifiable>(_ element : T) async throws where T.ID == String?
}

/// StorageListner
/// Implementering af Dependency Inversion Principle i SOLID &
/// Interface Segregation Principle fra SOLID
protocol StorageListner {
    func subscribe<T:Codable>(onChange: @escaping ([T]) -> Void)
    func unsubscribe()
}

