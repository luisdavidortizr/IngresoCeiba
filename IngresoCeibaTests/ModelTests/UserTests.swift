//
//  UserTests.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

@testable import Prueba_de_Ingreso
import Foundation
import XCTest

class UserTests: XCTestCase {
    
    func test_WhenDecodedFromJSON_DataHasAllTheInputProperties() throws {
        // Arrange the JSON Data input
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: "user",withExtension: "json")
        )
        let data = try Data(contentsOf: url)
        
        // Act by decoding a User instance from the Data
        let item = try JSONDecoder().decode(User.self, from: data)
        
        // Assert the MenuItem matches the input
        XCTAssertEqual(item.name, "Leanne Graham")
        XCTAssertEqual(item.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(item.email, "Sincere@april.biz")
    }
    
}
