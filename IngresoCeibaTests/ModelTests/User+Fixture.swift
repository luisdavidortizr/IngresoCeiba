//
//  User+Fixture.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 18/04/22.
//

@testable import IngresoCeiba

extension User {
    
    // Generador de usuario para pruebas
    static func fixture(
    id: Int = 1,
    name: String = "Leanne Graham",
    username: String = "Bret",
    email: String = "Sincere@april.biz",
    address: UserAddress = .fixture(),
    phone: String = "1-770-736-8031 x56442",
    website: String = "hildegard.org",
    company: UserCompany = .fixture()
    ) -> User {
        User(id: id, name: name, username: username, email: email, address: address, phone: phone, website: website, company: company)
    }
    
}

extension UserAddress {
    
    static func fixture(
    street: String = "Kulas Light",
    suite: String = "Apt. 556",
    city: String = "Gwenborough",
    zipcode: String = "92998-3874",
    geo: UserLocation = .fixture()
    ) -> UserAddress {
        UserAddress(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo)
    }
    
}

extension UserLocation {
    
    static func fixture(
    lat: String = "-37.3159",
    lng: String = "81.1496"
    ) -> UserLocation {
        UserLocation(lat: lat, lng: lng)
    }
    
}

extension UserCompany {
    
    static func fixture(
    name: String = "Romaguera-Crona",
    catchPhrase: String = "Multi-layered client-server neural-net",
    bs: String = "harness real-time e-markets"
    ) -> UserCompany {
        UserCompany(name: name, catchPhrase: catchPhrase, bs: bs)
    }
    
}
