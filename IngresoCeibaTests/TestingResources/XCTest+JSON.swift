//
//  XCTest+JSON.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

import XCTest

// Función para decodificar JSON en casos de prueba
extension XCTestCase {
    func dataFromJSONFileNamed(_ name: String) throws -> Data {
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: name,withExtension: "json")
        )
        return try Data(contentsOf: url)
    }
}
