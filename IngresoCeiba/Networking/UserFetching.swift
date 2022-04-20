//
//  UserFetching.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import Combine

// Protocolo para convertir la data de usuarios y publicaciones
protocol UserFetching {
    
    func fetchUsers() -> AnyPublisher<[User], Error>
    
    func fetchPosts(userId: Int) -> AnyPublisher<[Post], Error>
}
