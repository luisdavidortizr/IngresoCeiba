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
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    struct Address: Codable, Equatable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Location
        
        struct Location: Codable, Equatable {
            let lat: String
            let lng: String
        }
    }
    
    struct Company: Codable, Equatable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
