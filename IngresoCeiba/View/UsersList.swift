//
//  UsersView.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import SwiftUI

struct UsersList: View {
    
    // MARK: - Datos de la vista
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Estructura de la vista
    var body: some View {
        
        // Si se están cargando los datos muestra vista de progreso
        if viewModel.loading {
            
            ProgressView("Cargando datos...")
        
        } else {
            
            List {
                // Si la lista de usuarios a mostrar está vacía muestra texto "La lista está vacía"
                if viewModel.searchResults.isEmpty {
                    Text("La lista está vacía")
                }
                // Si la lista contiene usuarios muestra los UserRow
                ForEach(viewModel.searchResults, id: \.id) { user in
                    UserRow(viewModel: .init(user: user))
                }
            }.searchable(text: $viewModel.searchText) // La vista permite búsqueda
        }
    }
}

// MARK: - Previews
struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersList(viewModel: .init(userFetching: UserFetchingPlaceholder()))
    }
}
