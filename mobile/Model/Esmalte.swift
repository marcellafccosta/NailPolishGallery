//
//  Model.swift
//  Desafio10
//
//  Created by Turma01-18 on 27/03/25.
//

struct Esmalte: Hashable, Codable {
    var _id: String?
    var _rev: String?
    var nome: String
    var marca: String
    var acabamento: String
    var colecao: String
    var cor: String
    var foto: String?
}
