//
//  URLSession+NetworkFetching.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 19/04/22.
//

import Foundation
import Combine

// URLSession conforma al protocolo para dar la respuesta requerida
extension URLSession: NetworkFetching {
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
}
