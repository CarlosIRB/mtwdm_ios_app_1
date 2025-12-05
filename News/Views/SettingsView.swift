//
//  SettingsView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(SettingsViewModel.self) var settings
    @AppStorage("selectedCountry") var storedCountry = "us"

    var body: some View {
        Form {
            Section("País") {
                if settings.countriesLoading {
                    LoadingView()
                } else if let e = settings.countriesError {
                    ErrorView(message: e) { Task { await settings.loadCountries() } }
                } else {
                    Picker("País", selection: Binding(
                        get: { settings.selectedCountryCode },
                        set: { settings.selectedCountryCode = $0 }
                    )) {
                        ForEach(settings.countries) { c in
                            Text(c.name.common).tag(c.cca2.lowercased())
                        }
                    }
                }
            }

            Section("Categorías") {
                ForEach(settings.categories.keys.sorted(), id: \ .self) { key in
                    Toggle(key.capitalized, isOn: Binding(
                        get: { settings.categories[key] ?? false },
                        set: { settings.categories[key] = $0 }
                    ))
                }
            }

            Button("Cargar países") { Task { await settings.loadCountries() } }
        }
        .navigationTitle("Configuración")
        .task { await settings.loadCountries() }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(SettingsViewModel.shared)
    }
}
