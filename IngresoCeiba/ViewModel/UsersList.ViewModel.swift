//
//  UsersList.ViewModel.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import Combine
import Foundation

extension UsersList {
    
    class ViewModel: ObservableObject {
        
        // MARK: - Variables del Modelo de Vista
        var cancellables = Set<AnyCancellable>()
        
        @Published private(set) var users: Result<[User], Error> = .success([])
        @Published var searchText = String()
        @Published var loading: Bool
        
        // Resultado de la búsqueda
        var searchResults: [User] {
            do {
                let users = try users.get()
                let result = searchText.isEmpty ? users : users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                return result
            } catch {
                return []
            }
        }
        
        // MARK: - Constructores
        
        init(
            userFetching: UserFetching
        ) {
            loading = true
            userFetching
                .fetchUsers()
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard case .failure(let error) = completion else { return }
                        self?.loading = false
                        self?.users = .failure(error)
                    },
                    receiveValue: { [weak self] value in
                        self?.loading = false
                        self?.users = .success(value)
                        Storage.shared.savePersistentUsers(value)
                    })
                .store(in: &cancellables)
        }
        
        init(users: [User]) {
            self.users = .success(users)
            self.loading = false
        }
        
        convenience init(saveKey: String = Storage.saveKey, userFetching: UserFetching) {
            if let users = Storage.shared.loadPersistentUsers(forKey: saveKey) {
                self.init(users: users)
            } else {
                self.init(userFetching: userFetching)
            }
        }
        
    }
    
}
