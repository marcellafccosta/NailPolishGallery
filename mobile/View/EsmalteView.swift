//
//  EsmalteView.swift
//  Desafio10
//
//  Created by Turma01-18 on 27/03/25.
//
import SwiftUI

struct EsmalteView: View {
    @StateObject var viewModel = ViewModel()
    @State var recebeEsmalte: Esmalte?
    @State private var showDeleteConfirmation = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.azulclaro, .white, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 20) {
    
                    
                    
                    
                    if let fotoUrl = recebeEsmalte?.foto, let url = URL(string: fotoUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                   
                    Text(recebeEsmalte?.nome ?? "Nome não disponível")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        InfoRow(label: "Marca", value: recebeEsmalte?.marca)
                        InfoRow(label: "Cor", value: recebeEsmalte?.cor)
                        InfoRow(label: "Coleção", value: recebeEsmalte?.colecao)
                        InfoRow(label: "Acabamento", value: recebeEsmalte?.acabamento)
                    }
                    .padding(.top, 10)
                }
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    HStack {
                        Text("Apagar")
                            .foregroundColor(.red)
                            .font(.headline)
                            .bold()
                        
                        Image(systemName: "trash.fill")
                            .imageScale(.large)
                            .foregroundColor(.red)
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                    )
                }
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("Confirmar Exclusão"),
                        message: Text("Tem certeza que deseja apagar este item?"),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("Apagar"), action: {
                            if let esmalte = recebeEsmalte {
                                viewModel.deleteEsmalte(esmalte)
                                print("Esmalte deletado")
                                dismiss()
                            }
                        })
                    )
                }
                .padding(20)
            }
        }
    }
}

struct InfoRow: View {
    var label: String
    var value: String?
    
    var body: some View {
        HStack {
            Text("\(label):")
                .bold()
                .foregroundColor(.secondary)
            Text(value ?? "Não disponível")
                .foregroundColor(.primary)
                .padding(5)
        }
    }
}

#Preview {
    EsmalteView()
}
