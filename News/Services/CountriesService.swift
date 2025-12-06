//
//  CountriesService.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Foundation

final class CountriesService {
    static let shared = CountriesService()
    private init() {}

    func fetchAll() async throws -> [Country] {
        guard var components = URLComponents(string: Config.restCountriesURL + "/all") else {
            throw NetworkError.invalidURL
        }
        components.queryItems = [
            URLQueryItem(name: "fields", value: "name,cca2,flags")
        ]
        let url = components.url!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let http = response as? HTTPURLResponse,
            !(200...299).contains(http.statusCode) {
            throw NetworkError.serverError(http.statusCode)
        }

        return try JSONDecoder().decode([Country].self, from: data)
    }
}

