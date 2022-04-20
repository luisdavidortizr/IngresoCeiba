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
        let location = User.Address.Location(lat: "-37.3159", lng: "81.1496")
        let address = User.Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: location)
        let company = User.Company(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
        let user = User(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "website", company: company)
        UserPosts(viewModel: .init(user: user, userFetching: UserFetchingPlaceholder()))
    }
}
