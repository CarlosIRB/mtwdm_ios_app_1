//
//  HomeView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = NewsViewModel()
    @Environment(SettingsViewModel.self) var settings

    var body: some View {
        List {
            Section() {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 16) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 36))
                            .foregroundStyle(.white)
                            .symbolEffect(.pulse)

                        VStack(alignment: .leading) {
                            Text("Bienvenido")
                                .font(.title2).bold()
                                .foregroundColor(.white)

                            Text("Explora las últimas noticias del mundo")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }

                    Text("Selecciona una categoría o revisa los titulares más recientes.")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)   // ← asegura ancho completo
                .background(
                    LinearGradient(colors: [.blue, .purple],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .cornerRadius(12)
                .listRowInsets(.init())            // ← elimina márgenes automáticos del List
                .listRowBackground(Color.clear)    // ← evita que List ponga fondo blanco
            }

            
            Section("Categorías") {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(
                            settings.categories
                                .filter { $0.value }              // solo activadas
                                .map { $0.key }
                                .sorted(),
                            id: \.self
                        ) { c in
                            Button {
                                Task { await vm.loadCategory(c, country: settings.selectedCountryCode) }
                            } label: {
                                VStack {
                                    Image(systemName: "newspaper")
                                    Text(c.capitalized).font(.caption)
                                }
                                .padding(8).background(.thinMaterial).cornerRadius(10)
                            }
                        }
                    }
                }
            }
            Section("Noticias Destacadas: \(settings.selectedCountryName) \(settings.selectedCountryCode)") {
                switch vm.state {
                case .idle: Text("Pulsa para cargar")
                case .loading: LoadingView()
                case .failure(let e): ErrorView(message: e.localizedDescription) {
                        Task { await vm.loadTop(country: settings.selectedCountryCode) }
                }
                case .success(let list):
                    if list.isEmpty {
                        VStack(alignment: .center, spacing: 16) {
                            Image(systemName: "globe.europe.africa")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)

                            Text("No hay noticias disponibles para este país.")
                                .font(.headline)
                                .multilineTextAlignment(.center)

                            Text("Prueba seleccionando otro país en la configuración.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                    } else {
                        ForEach(list) { a in
                            NavigationLink(value: a) { NewsRowView(article: a) }
                        }
                    }
                }
            }


            NavigationLink("Acerca de", destination: AboutView())
        }
        .navigationTitle("Noticias")
        .task { await vm.loadTop(country: settings.selectedCountryCode) }
        .navigationDestination(for: Article.self) { a in NewsDetailView(article: a) }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(SettingsViewModel.shared)
    }
}
