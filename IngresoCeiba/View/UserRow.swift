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
            Text(viewModel.user.name)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Teléfono del usuario
            HStack {
                Image(systemName: "phone.fill")
                Text(viewModel.user.phone)
            }
            
            // Correo del usuario
            HStack {
                Image(systemName: "envelope.fill")
                Text(viewModel.user.email)
            }
            
            // Botón para ver publicaciones
            HStack {
                Button("Ver Publicaciones") {}
                    .padding(.top)
                    .foregroundColor(.blue)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
            NavigationLink {
                UserPosts(viewModel: .init(user: viewModel.user, userFetching: UserFetcher()))
            } label: {
                EmptyView()
            }
            
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
