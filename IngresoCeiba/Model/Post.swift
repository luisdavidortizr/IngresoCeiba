//
//  Post.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

// MARK: - Estructuras de publicación

struct Post: Codable, Equatable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
