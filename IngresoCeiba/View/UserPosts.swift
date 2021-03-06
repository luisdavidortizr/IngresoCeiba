//
//  UserPosts.swift
//  IngresoCeiba
//
//  Created by Luis David Ortiz on 19/04/22.
//

import SwiftUI

struct UserPosts: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    Image(systemName: "phone.fill")
                    Text(viewModel.user.phone)
                }.frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(viewModel.user.email)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text("Publicaciones:")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            if viewModel.loading {
                
                ProgressView("Cargando publicaciones...")
            
            } else {
                switch viewModel.posts {
                case .success(let posts):
                    List {
                        if posts.isEmpty {
                            Text("No hay publicaciones para mostrar")
                        }
                        
                        ForEach(posts, id: \.id) { post in
                            VStack {
                                Text(post.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                Spacer(minLength: 15)
                                Text(post.body)
                                    .minimumScaleFactor(0.5)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }.frame(maxWidth: .infinity)
                                .padding(.vertical)
                        }
                    }
                case .failure(let error):
                    Text("Ha ocurrido un error:")
                    Text(error.localizedDescription).italic()
                }
            }
            
        }.navigationTitle(viewModel.user.name)
    }
    
}

struct UserPosts_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 1, name: "Leanne Graham",email: "Sincere@april.biz", phone: "1-770-736-8031 x56442")
        UserPosts(viewModel: .init(user: user, userFetching: UserFetchingPlaceholder()))
    }
}
