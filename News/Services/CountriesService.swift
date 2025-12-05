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
        guard let url = URL(string: Config.restCountriesURL) else { throw NetworkError.invalidURL }
        return try await NetworkService.shared.request(url: url)
    }
}
