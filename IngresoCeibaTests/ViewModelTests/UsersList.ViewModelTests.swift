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
    let saveKey = "TestUsers"
    
    // MARK: - Pruebas de persistencia de datos
    
    // Al intentar cargar los datos y no hay datos guardados, devuelve nil
    func test_WhenNoUsersSaved_LoadingReturnsNilValue() {
        UserDefaults.standard.removeObject(forKey: saveKey)
        let savedUsers = Storage.shared.loadPersistentUsers(forKey: saveKey)
        
        XCTAssertNil(savedUsers)
    }
    
    // Al intentar cargar los datos y hay usuarios guardados, devuelve una lista de usuarios
    func test_WhenUsersExistInDefaults_LoadingReturnsUserList() throws {
        let data = try dataFromJSONFileNamed("users")
        let users = try JSONDecoder().decode([User].self, from: data)
        
        let jsonData = try? JSONEncoder().encode(users)
        UserDefaults.standard.set(jsonData, forKey: saveKey)
        
        let savedUsers = Storage.shared.loadPersistentUsers(forKey: saveKey)
        
        XCTAssertEqual(savedUsers, users)
    }
    
    // MARK: - Prueba de Integración: Carga de usuarios desde Defaults + Descarga de nuevos usuarios
    
    // Si los datos existen, el controlador debe usar estos y no cargarlos del servidor
    func test_WhenUsersSaved_NoLoadFromServer() throws {
        let data = try dataFromJSONFileNamed("users")
        UserDefaults.standard.set(data, forKey: saveKey)
        let expectedUsers = try JSONDecoder().decode([User].self, from: data)
        
        let viewModel = UsersList.ViewModel(saveKey: saveKey,userFetching: UserFetchingStub(returning: .success([.fixture()])))
        let users = try viewModel.users.get()
        
        XCTAssertEqual(users, expectedUsers)
        XCTAssertFalse(viewModel.loading)
    }
    
    // Si los usuarios no están guardados el ViewModel debe descargarlos del servidor
    func test_WhenUsersNotSaved_LoadUsersFromServer() throws {
        UserDefaults.standard.removeObject(forKey: saveKey)
        let viewModel = UsersList.ViewModel(userFetching: UserFetchingStub(returning: .success([.fixture()])))
        let users = try viewModel.users.get()
        
        XCTAssertTrue(users.isEmpty)
        XCTAssertTrue(viewModel.loading)
    }
    
    // Si los usuarios están guardados debe cargar estos y no los del servidor
    
    //MARK: - Pruebas de descarga de usuarios
    
    // Al Iniciar la descarga de usuarios publica una lista vacía y la variable loading está en true
    func test_WhenFetchingStarts_PublishesEmpyUserList() throws {
        // En esta versión ya el test es innecesario porque lo reemplaza test_WhenUsersNotSaved_LoadUsersFromServer
        try XCTSkipIf(true, "Test no longer needed, replaced by test_WhenUsersNotSaved_LoadUsersFromServer")
        
        // Se carga el modelo
        let viewModel = UsersList.ViewModel(userFetching: UserFetchingStub(returning: .success([.fixture()])))
        let users = try viewModel.users.get()
        
        // La lista está vacía
        XCTAssertTrue(users.isEmpty)
        
        // La variable de carga está en true
        XCTAssertTrue(viewModel.loading)
    }
    
    // Al finalizar la descarga con éxito publica la lista de usuarios y loading está en false
    func test_WhenFetchingSucceeds_PublishesUsersList() {
        // Se configura el modelo y los datos esperados
        let expectedUsers = [User.fixture()]
        let userFetchingStub = UserFetchingStub(returning: .success(expectedUsers))
        let viewModel = UsersList.ViewModel(userFetching: userFetchingStub)
        let expectation = XCTestExpectation(description: "Publishes users from received array")
        
        // Se simula la descarga de usuarios
        viewModel
            .$users
            .dropFirst() // Se descarta valor por defecto
            .sink { value in
                guard case .success(let users) = value else {
                    return XCTFail("Expected a successful Result, got \(value)")
                }
                // La lista cargada es la esperada
                XCTAssertEqual(users, expectedUsers)
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
        let userFetchingStub = UserFetchingStub(returning: .failure(expectedError))
        let viewModel = UsersList.ViewModel(userFetching: userFetchingStub)
        let expectation = XCTestExpectation(description: "Publishes an error")
        
        // Se simula la descarga con errores
        viewModel
            .$users
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
    
    // MARK: - Pruebas de búsqueda
    
    // Cuando no hay texto de búsqueda devuelve toda la lista de usuarios
    func test_WhenNoSearchText_PublishesAllUsers() throws {
        let data = try dataFromJSONFileNamed("users")
        let users = try JSONDecoder().decode([User].self, from: data)
        let viewModel = UsersList.ViewModel(users: users)
        
        viewModel.searchText = ""
        XCTAssertEqual(viewModel.searchResults, users)
    }
    
    // Cuando se busca un texto devuelve los usuarios que lo contengan en el nombre
    func test_WhenUserSearchesExistingName_PublishesUsersContainingSearchText() throws {
        let data = try dataFromJSONFileNamed("users")
        let users = try JSONDecoder().decode([User].self, from: data)
        let viewModel = UsersList.ViewModel(users: users)
        
        viewModel.searchText = "Leanne"
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults.first?.name, "Leanne Graham")
    }
    
    // Cuando se busca un nombre que no existe devuelve una lista vacía
    func test_WhenUserSearchesNonExistingText_PublishesEmptyUserList() throws {
        let data = try dataFromJSONFileNamed("users")
        let users = try JSONDecoder().decode([User].self, from: data)
        let viewModel = UsersList.ViewModel(users: users)
        
        viewModel.searchText = "Patrick"
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
    
}
