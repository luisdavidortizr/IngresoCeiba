//
//  UsersList.ViewModel.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import Combine

extension UsersList {
    
    class ViewModel: ObservableObject {
        
        // MARK: - Variables del Modelo de Vista
        var cancellables = Set<AnyCancellable>()
        
        @Published private(set) var users: [User]
        @Published var searchText = String()
        @Published var loading: Bool
        
        // Resultado de la búsqueda
        var searchResults: [User] {
            if searchText.isEmpty {
                return users
            } else {
                return users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        // MARK: - Constructores
        init(
            userFetching: UserFetching
        ) {
            users = []
            loading = true
            userFetching
                .fetchUsers()
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
                    self?.loading = false
                    self?.users = value
                })
                .store(in: &cancellables)
        }
        
    }
    
}
