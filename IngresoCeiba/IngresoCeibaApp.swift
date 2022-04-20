//
//  IngresoCeibaApp.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import SwiftUI

@main
struct IngresoCeibaApp: App {
    var body: some Scene {
        WindowGroup {
            // Vista de navegación con título de la app
            NavigationView {
                UsersList(
                    viewModel: .init(saveKey: Storage.saveKey,userFetching: UserFetcher())
                ).navigationTitle("Prueba de Ingreso")
            }
        }
    }
}
