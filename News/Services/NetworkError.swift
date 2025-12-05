//
//  NetworkError.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "URL inválida"
        case .noData: return "Sin datos"
        case .decodingError: return "Error al decodificar"
        case .serverError(let c): return "Error de servidor: \(c)"
        }
    }
}
