//
//  User+Fixture.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 18/04/22.
//

@testable import Prueba_de_Ingreso

extension User {
    
    // Generador de usuario para pruebas
    static func fixture(
    id: Int = 1,
    name: String = "Leanne Graham",
    email: String = "Sincere@april.biz",
    phone: String = "1-770-736-8031 x56442"
    ) -> User {
        User(id: id, name: name, email: email, phone: phone)
    }
    
}
