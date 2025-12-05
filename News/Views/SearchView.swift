//
//  SearchView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    @State private var vm = NewsViewModel()

    var body: some View {
        VStack {
            HStack {
                TextField("Buscar", text: $text)
                    .textFieldStyle(.roundedBorder)
                Button("Ir") { Task { await vm.search(text) } }
            }
            .padding()

            Button("Tema sorpresa") { Task { await randomSearch() } }

            switch vm.state {
            case .idle: Text("Ingrese un término")
            case .loading: LoadingView()
            case .failure(let e): ErrorView(message: e.localizedDescription) { Task { await vm.search(text) } }
            case .success(let list):
                List(list) { a in
                    NavigationLink(value: a) { NewsRowView(article: a) }
                }
            }
        }
        .navigationDestination(for: Article.self) { a in NewsDetailView(article: a) }
        .navigationTitle("Buscar")
    }

    private func randomSearch() async {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word") else { return }
        do {
            let (d, _) = try await URLSession.shared.data(from: url)
            if let w = try? JSONDecoder().decode([String].self, from: d).first {
                text = w
                await vm.search(w)
            }
        } catch { return }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
