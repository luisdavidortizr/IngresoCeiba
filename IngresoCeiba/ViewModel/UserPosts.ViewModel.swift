//
//  UserPosts.ViewModel.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 19/04/22.
//

import Combine

extension UserPosts {
    
    class ViewModel: ObservableObject {
        
        // MARK: - Variables del Modelo de Vista
        var cancellables = Set<AnyCancellable>()
        
        @Published var user: User
        @Published var posts: Result<[Post], Error> = .success([])
        @Published var loading: Bool
        
        // MARK: - Constructores
        init(user: User, userFetching: UserFetching) {
            self.user = user
            self.loading = true
            userFetching
                .fetchPosts(userId: user.id)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard case .failure(let error) = completion else {return}
                        self?.loading = false
                        self?.posts = .failure(error)
                    },
                    receiveValue: { [weak self] value in
                        self?.loading = false
                        self?.posts = .success(value)
                    }
                ).store(in: &cancellables)
        }
        
    }
    
}
