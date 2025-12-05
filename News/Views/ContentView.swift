//
//  ContentView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }
                .tabItem { Label("Inicio", systemImage: "house") }

            NavigationStack { SearchView() }
                .tabItem { Label("Buscar", systemImage: "magnifyingglass") }

            NavigationStack { PinnedView() }
                .tabItem { Label("Guardados", systemImage: "bookmark") }

            NavigationStack { SettingsView() }
                .tabItem { Label("Configuración", systemImage: "gearshape") }
        }
    }
}

#Preview {
    ContentView()
        .environment(SettingsViewModel.shared)
        .environment(PinnedViewModel.shared)
}
