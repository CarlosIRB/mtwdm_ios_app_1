//
//  SettingsViewModel.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Observation
import Foundation

@Observable
final class SettingsViewModel: Observable {
    static let shared = SettingsViewModel()
    
    private let keyCountry = "selectedCountry"
    
    var selectedCountryCode: String {
            get { UserDefaults.standard.string(forKey: keyCountry) ?? "us" }
            set { UserDefaults.standard.set(newValue, forKey: keyCountry) }
        }

    var categories: [String: Bool] = [
        "business": true,
        "entertainment": true,
        "general": true,
        "health": true,
        "science": true,
        "sports": true,
        "technology": true
    ]

    var countries: [Country] = []
    var countriesLoading = false
    var countriesError: String? = nil

    @MainActor
    func loadCountries() async {
        guard countries.isEmpty else { return }
        countriesLoading = true
        do {
            let all = try await CountriesService.shared.fetchAll()
            
            countries = all.sorted { $0.name.common < $1.name.common }
            countriesLoading = false
        } catch {
            
            countriesError = error.localizedDescription
            countriesLoading = false
        }
    }
}
