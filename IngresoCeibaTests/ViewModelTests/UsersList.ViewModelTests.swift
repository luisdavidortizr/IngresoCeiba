//
//  UsersList.ViewModelTests.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 18/04/22.
//

import Combine
import Foundation
import XCTest
@testable import Prueba_de_Ingreso

// Casos de Prueba: Vista de Usuarios
class UsersListViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    //MARK: Pruebas de descarga de usuarios
    
    // Al Iniciar la descarga de usuarios publica una lista vacía y la variable loading está en true
    func test_WhenFetchingStarts_PublishesEmpyUserList() {
        // Se carga el modelo con el placeholder
        let viewModel = UsersList.ViewModel(userFetching: UserFetchingPlaceholder())
        
        // La lista está vacía
        XCTAssertTrue(viewModel.users.isEmpty)
        
        // La variable de carga está en true
        XCTAssertTrue(viewModel.loading)
    }
    
    // Al finalizar la descarga con éxito publica la lista de usuarios y loading está en false
    func test_WhenFetchingSucceeds_PublishesUsersList() {
        // Se configura el modelo y los datos esperados
        let expectedUsers = [User.fixture()]
        let viewModel = UsersList.ViewModel(userFetching: UserFetchingPlaceholder())
        let expectation = XCTestExpectation(description: "Publishes users from received array")
        
        // Se simula la descarga de usuarios
        viewModel
            .$users
            .dropFirst() // Se descarta valor por defecto
            .sink { value in
                // La lista cargada es la esperada
                XCTAssertEqual(value, expectedUsers)
                // La varible de carga está en false
                XCTAssertFalse(viewModel.loading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func test_WhenFetchingFails_PublishesAnError() {}
    
    // MARK: - Pruebas de búsqueda
    
    // Cuando no hay texto de búsqueda devuelve toda la lista de usuarios
    func test_WhenNoSearchText_PublishesAllUsers() {}
    
    // Cuando se busca un texto devuelve los usuarios que lo contengan en el nombre
    func test_WhenUserSearchesExistingName_PublishesUsersContainingSearchText() {}
    
    // Cuando se busca un nombre que no existe devuelve una lista vacía
    func test_WhenUserSearchesNonExistingText_PublishesEmptyUserList() {}
    
}
