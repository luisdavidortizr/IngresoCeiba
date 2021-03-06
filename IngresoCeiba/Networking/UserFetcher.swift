//
//  UserFetcher.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 19/04/22.
//

import Combine
import Foundation

// Clase para obtener información de usuarios y publicaciones del servidor
class UserFetcher: UserFetching {
    
    let networkFetching: NetworkFetching
    
    init(networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
    }
    
    // Función de carga de usuarios
    func fetchUsers() -> AnyPublisher<[User], Error> {
        
        let url = URL(string: Endpoints.usersUrl)!
        
        return networkFetching
            .load(URLRequest(url: url))
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    // Función de carga de publicaciones
    func fetchPosts(userId: Int) -> AnyPublisher<[Post], Error> {
        
        var url = URLComponents(string: Endpoints.postsUrl)!
        url.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        let request = URLRequest(url: url.url!)
        
        return networkFetching
            .load(request)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
