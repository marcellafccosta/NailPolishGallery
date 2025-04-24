//
//  ViewModel.swift
//  Desafio10
//
//  Created by Turma01-18 on 27/03/25.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var esmaltes: [Esmalte] = []
    @Published var nome: String = ""
    @Published var marca: String = ""
    @Published var acabamento: String = ""
    @Published var colecao: String = ""
    @Published var cor: String = ""
    @Published var foto: String = ""
    
    func fetch() {
        guard let url = URL(string: "http://127.0.0.1:1880/cellaget") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Esmalte].self, from: data)
                DispatchQueue.main.async {
                    self?.esmaltes = parsed
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func addEsmalte(_ esmalte: Esmalte) {
        esmaltes.append(esmalte)
        
        guard let url = URL(string: "http://127.0.0.1:1880/cellapost") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(esmalte)
            request.httpBody = jsonData
        } catch {
            print(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            do {
                let parsed = try JSONDecoder().decode(Esmalte.self, from: data)
                DispatchQueue.main.async {
                    self?.esmaltes.append(parsed)
                }
            } catch {
                print(error)
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                print("Esmalte adicionado com sucesso!")
            } else {
                print("Não foi possível adicionar novo esmalte :( \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        }
        task.resume()
    }
    
    func deleteEsmalte(_ esmalte: Esmalte){
        guard let url = URL(string: "http://127.0.0.1:1880/celladelete") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let data = try JSONEncoder().encode(esmalte)
            
            print(esmalte)
            
            request.httpBody = data
            
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error deleting resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource deleted successfully")
            } else {
                print("Error deleting resource: status code \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
        
        if let index = esmaltes.firstIndex(of: esmalte){
            esmaltes.remove(at: index)
        }
        
        
    }

}
