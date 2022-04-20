//
//  Post+Fixture.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

@testable import Prueba_de_Ingreso

extension Post {
    
    // Generador de publicación para pruebas
    static func fixture(
        userId: Int = 1,
        id: Int = 1,
        title: String = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        body: String = "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    ) -> Post {
        return Post(userId: userId, id: id, title: title, body: body)
    }
    
}
