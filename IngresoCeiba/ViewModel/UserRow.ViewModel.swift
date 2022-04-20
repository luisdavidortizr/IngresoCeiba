//
//  UsersRow.ViewModel.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

extension UserRow {
    
    struct ViewModel {
        
        // MARK: - Variables del Modelo de Vista
        let user: User
        
        // MARK: - Constructores
        init(user: User) {
            self.user = user
        }
        
    }
    
}
