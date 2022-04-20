//
//  PostFetchingStub.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

@testable import Prueba_de_Ingreso
import Foundation
import Combine

// Para pruebas de carga de usuarios
class PostFetchingStub: UserFetching {
    let result: Result<[Post], Error>
    
    init(returning result: Result<[Post], Error>) {
        self.result = result
    }
    
    func fetchPosts(userId: Int) -> AnyPublisher<[Post], Error> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return Result<[User], Error>.failure(TestError(id: 0)).publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
