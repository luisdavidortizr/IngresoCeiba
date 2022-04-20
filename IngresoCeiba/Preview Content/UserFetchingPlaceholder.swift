//
//  UserFetchingPlaceholder.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import Combine
import Foundation

// Placeholder que conformaa el protocolo de carga de usuarios
// Por motivos de testing
class UserFetchingPlaceholder: UserFetching {
    
    // Usuario de prueba
    let user = User(
        id: 1,
        name: "Leanne Graham",
        email: "Sincere@april.biz",
        phone: "1-770-736-8031 x56442"
    )
    
    let post = Post(
      userId: 1,
      id: 1,
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    )
    
    // Carga de usuarios
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return Future { $0(.success([self.user])) }
            // Use a Delay to simulate async fetch
            .delay(for: 0.5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchPosts(userId: Int) -> AnyPublisher<[Post], Error> {
        return Future { $0(.success([self.post])) }
            // Use a Delay to simulate async fetch
            .delay(for: 0.5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
