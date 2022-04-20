//
//  UserPosts.ViewModelTests.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

import Combine
import Foundation
import XCTest
@testable import Prueba_de_Ingreso

// Casos de Prueba: Vista de Publicaciones
class UserPostsViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    // Al Iniciar la descarga de publicaciones, publica una lista vacía y la variable loading está en true
    func test_WhenFetchingStarts_PublishesEmpyUserList() throws {
        // Se carga el modelo
        let viewModel = UserPosts.ViewModel(user: User.fixture() ,userFetching: PostFetchingStub(returning: .success([.fixture()])))
        let posts = try viewModel.posts.get()
        
        // La lista está vacía
        XCTAssertTrue(posts.isEmpty)
        
        // La variable de carga está en true
        XCTAssertTrue(viewModel.loading)
    }
    
    // Al finalizar la descarga con éxito, publica la lista de publicaciones y loading está en false
    func test_WhenFetchingSucceeds_PublishesUsersList() {
        // Se configura el modelo y los datos esperados
        let expectedPosts = [Post.fixture()]
        let postFetchingStub = PostFetchingStub(returning: .success(expectedPosts))
        let viewModel = UserPosts.ViewModel(user: User.fixture(), userFetching: postFetchingStub)
        let expectation = XCTestExpectation(description: "Publishes posts from received array")
        
        // Se simula la descarga de publicaciones
        viewModel
            .$posts
            .dropFirst() // Se descarta valor por defecto
            .sink { value in
                guard case .success(let posts) = value else {
                    return XCTFail("Expected a successful Result, got \(value)")
                }
                // La lista cargada es la esperada
                XCTAssertEqual(posts, expectedPosts)
                // La varible de carga está en false
                XCTAssertFalse(viewModel.loading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    // Al encontrar un error en la descarga de datos publica el error
    func test_WhenFetchingFails_PublishesAnError() {
        // Se configura el modelo y los datos esperados
        let expectedError = TestError(id: 123)
        let postFetchingStub = PostFetchingStub(returning: .failure(expectedError))
        let viewModel = UserPosts.ViewModel(user: User.fixture(),userFetching: postFetchingStub)
        let expectation = XCTestExpectation(description: "Publishes an error")
        
        // Se simula la descarga con errores
        viewModel
            .$posts
            .dropFirst() // Se descarta valor por defecto
            .sink { value in
                guard case .failure(let error) = value else {
                    return XCTFail("Expected a failing Result, got \(value)")
                }
                
                // El error obtenido es el esperado
                XCTAssertEqual(error as? TestError, expectedError)
                // La varible de carga está en false
                XCTAssertFalse(viewModel.loading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
}
