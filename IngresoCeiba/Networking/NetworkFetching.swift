//
//  NetworkFetching.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 19/04/22.
//

import Foundation
import Combine

protocol NetworkFetching {
    
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
    
}
