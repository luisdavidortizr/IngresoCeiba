//
//  User.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

// MARK: - Estructuras de usuario
struct User: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
}
