//
//  Profile.swift
//  Desafio10
//
//  Created by Turma01-18 on 31/03/25.
//
import SwiftUI

struct Profile: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.azulclaro, .white, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView(.vertical) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding(20)
                        
                        Text("Nome de Usuario")
                            .font(.title2)
                        
                        VStack {
                            Text("Favoritos")
                                .font(.headline)
                                .padding(10)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.esmaltes.prefix(5), id: \.self) { index in
                                        NavigationLink(destination: EsmalteView(recebeEsmalte: index)) {
                                            VStack {
                                                if let fotoUrl = index.foto, let url = URL(string: fotoUrl) {
                                                    AsyncImage(url: url) { image in
                                                        image.resizable()
                                                            .scaledToFit()
                                                            .frame(width: 150, height: 150)
                                                    } placeholder: {
                                                        ProgressView()
                                                            .progressViewStyle(CircularProgressViewStyle())
                                                    }
                                                } else {
                                                    Image(systemName: "photo")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 150, height: 150)
                                                }
                                                Text(index.nome)
                                                    .foregroundStyle(.black)
                                                    .font(.caption)
                                                    .padding(.top, 4)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .onAppear {
                                    viewModel.fetch()
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                }}
        }}
}

#Preview {
    Profile()
}
