//
//  Storage.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 20/04/22.
//

import Foundation

// Utilidad con shared instance para guardar y cargar datos de UserDefaults
class Storage {
    
    static let shared: Storage = Storage()
    static let saveKey: String = "Users"
    
    func loadPersistentUsers(forKey key: String = saveKey) -> [User]? {
        if let data = UserDefaults.standard.object(forKey: key) as? Data,
           let users = try? JSONDecoder().decode([User].self, from: data){
            return users
        } else {
            return nil
        }
    }
    
    func savePersistentUsers(_ users: [User], forKey key: String = saveKey) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
}
