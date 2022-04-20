//
//  UserFetchingStub.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

@testable import Prueba_de_Ingreso
import Foundation
import Combine

// Para pruebas de carga de usuarios
class UserFetchingStub: UserFetching {
    let result: Result<[User], Error>
    
    init(returning result: Result<[User], Error>) {
        self.result = result
    }
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchPosts(userId: Int) -> AnyPublisher<[Post], Error> {
        return Result<[Post], Error>.failure(TestError(id: 0)).publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
