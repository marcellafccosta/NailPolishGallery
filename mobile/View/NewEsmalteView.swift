//
//  NewEsmalteView.swift
//  Desafio10
//
//  Created by Turma01-18 on 28/03/25.
//

import SwiftUI

struct NewEsmalteView: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    @State var novoEsmalte : Esmalte?
    
    
    var body: some View {
        Form {
            Section(header: Text("Detalhes do Esmalte")) {
                TextField("Nome ", text: $viewModel.nome)
                TextField("Marca ", text: $viewModel.marca)
                TextField("Acabamento ", text: $viewModel.acabamento)
                TextField("Coleção ", text: $viewModel.colecao)
                TextField("Cor ", text: $viewModel.cor)
                TextField("Foto ", text: $viewModel.foto)
            }
            Button("Adicionar", action: {
                let newEsmalte = Esmalte(nome: viewModel.nome, marca: viewModel.marca, acabamento: viewModel.acabamento, colecao: viewModel.colecao, cor: viewModel.cor, foto: viewModel.foto)
                viewModel.addEsmalte(newEsmalte)
                dismiss()
            })
            .frame(maxWidth: .infinity)
            .navigationTitle("Novo Esmalte")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewEsmalteView()
}
