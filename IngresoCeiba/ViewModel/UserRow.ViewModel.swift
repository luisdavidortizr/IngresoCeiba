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
        let name: String
        let phone: String
        let email: String
        
        // MARK: - Constructores
        init(user: User) {
            self.name = user.name
            self.phone = user.phone
            self.email = user.email
            self.user = user
        }
        
    }
    
}
