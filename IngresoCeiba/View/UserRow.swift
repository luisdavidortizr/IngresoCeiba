//
//  UserRow.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 18/04/22.
//

import SwiftUI

struct UserRow: View {
    
    // MARK: - Datos de la vista
    let viewModel: ViewModel
    
    // MARK: - Estructura de la vista
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Nombre del usuario
            Text(viewModel.name)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Teléfono del usuario
            HStack {
                Image(systemName: "phone.fill")
                Text(viewModel.phone)
            }
            
            // Correo del usuario
            HStack {
                Image(systemName: "envelope.fill")
                Text(viewModel.email)
            }
            
            // Botón para ver publicaciones
            HStack {
                Button("Ver Publicaciones") {
                    
                }.padding(.top)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
        }.padding()
        
    }
        
}

// MARK: - Previews
struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserRow.ViewModel(user: UserFetchingPlaceholder().user)
        UserRow(viewModel: viewModel)
    }
}
