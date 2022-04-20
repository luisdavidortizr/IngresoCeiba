//
//  NetworkFetchingStub.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

@testable import Prueba_de_Ingreso
import Combine
import Foundation

// Se simula una clase que conforma al protocolo NetworkFetching
class NetworkFetchingStub: NetworkFetching {
    
    private let result: Result<Data, URLError>
    
    init(returning result: Result<Data, URLError>) {
        self.result = result
    }
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result.publisher
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
