//
//  ContentView.swift
//  Desafio10
//
//  Created by Turma01-18 on 27/03/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var searchEsmalte = ""
    
    var filteredEsmaltes: [Esmalte] {
        if searchEsmalte.isEmpty {
            return viewModel.esmaltes
        } else {
            return viewModel.esmaltes.filter { $0.nome.localizedCaseInsensitiveContains(searchEsmalte) }
        }
    }
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.azulclaro, .white, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                ScrollView {
                    NavigationLink("Adicionar Esmalte", destination: NewEsmalteView())
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom)
                    
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(filteredEsmaltes, id: \.self) { esmalte in
                            NavigationLink(destination: EsmalteView(recebeEsmalte: esmalte)) {
                                VStack {
                                    if let fotoUrl = esmalte.foto, let url = URL(string: fotoUrl) {
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
                                    
                                    Text(esmalte.nome)
                                        .foregroundStyle(.black)
                                        .padding(.leading, 8)
                                }
                                .padding(.vertical, 4)
                                
                            }
                        }
                    }
                    .onAppear {
                        viewModel.fetch()
                    }
                }
                .searchable(text: $searchEsmalte)
                .navigationTitle("Galeria de Esmaltes")
                
            }
        }
    }
}

#Preview {
    ContentView()
}
