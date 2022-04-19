//
//  UserFetching.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import Combine

// Protocolo para carga de usuarios
protocol UserFetching {
    
    func fetchUsers() -> AnyPublisher<[User], Error>
}
