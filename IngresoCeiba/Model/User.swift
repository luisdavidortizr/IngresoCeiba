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
    let username: String
    let email: String
    let address: UserAddress
    let phone: String
    let website: String
    let company: UserCompany
}

struct UserLocation: Codable, Equatable {
    let lat: String
    let lng: String
}

struct UserAddress: Codable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: UserLocation
}

struct UserCompany: Codable, Equatable {
    let name: String
    let catchPhrase: String
    let bs: String
}
