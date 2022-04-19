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
        username: "Bret",
        email: "Sincere@april.biz",
        address: UserAddress(street: "Kulas Light",
                             suite: "Apt. 556",
                             city: "Gwenborough",
                             zipcode: "92998-3874",
                             geo: UserLocation(
                                lat: "-37.3159",
                                lng: "81.1496")
                            ),
        phone: "1-770-736-8031 x56442",
        website: "hildegard.org",
        company: UserCompany(name: "Romaguera-Crona",
                             catchPhrase: "Multi-layered client-server neural-net",
                             bs: "harness real-time e-markets")
    )
    
    // Carga de usuarios
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return Future { $0(.success([self.user])) }
            // Use a Delay to simulate async fetch
            .delay(for: 0.5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
