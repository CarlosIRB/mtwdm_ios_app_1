//
//  SettingsView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(SettingsViewModel.self) var settings
    
    @State private var showCountryPicker = false
    @State private var countrySearch = ""

    var body: some View {
        Form {
            
            Section("País") {
                if settings.countriesLoading {
                    LoadingView()
                } else if let e = settings.countriesError {
                    ErrorView(message: e) { Task { await settings.loadCountries() } }
                } else {
                    Button {
                        showCountryPicker = true
                    } label: {
                        HStack {
                            Text("País")
                            Spacer()
                            Text(settings.selectedCountryName)
                                .foregroundColor(.secondary)
                            Text(settings.selectedCountryCode)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            // MARK: Categorías
            Section("Categorías") {
                ForEach(settings.categories.keys.sorted(), id: \.self) { key in
                    Toggle(key.capitalized, isOn: Binding(
                        get: { settings.categories[key] ?? false },
                        set: { settings.categories[key] = $0 }
                    ))
                }
            }

            
        }
        .navigationTitle("Configuración")
        .task { await settings.loadCountries() }
        .sheet(isPresented: $showCountryPicker) {
            countryPickerSheet
        }
    }
    
    
}

extension SettingsView {
    var countryPickerSheet: some View {
        NavigationStack {
            VStack {
                TextField("Buscar país", text: $countrySearch)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                List(filteredCountries) { c in
                    Button {
                        settings.selectedCountryCode = c.cca2.lowercased()
                        showCountryPicker = false
                    } label: {
                        HStack {
                            Text(c.name.common)
                            Spacer()
                            if c.cca2.lowercased() == settings.selectedCountryCode {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Seleccionar país")
            .toolbar {
                Button("Cerrar") {
                    showCountryPicker = false
                }
            }
        }
    }

    // Filtro dinámico
    var filteredCountries: [Country] {
        if countrySearch.isEmpty { return settings.countries }
        return settings.countries.filter {
            $0.name.common.lowercased().contains(countrySearch.lowercased())
        }
    }
}


#Preview {
    NavigationStack {
        SettingsView()
            .environment(SettingsViewModel())
    }
}
