//
//  NewsListView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

private struct PinnedKey: EnvironmentKey {
    static let defaultValue = PinnedViewModel.shared
}

extension EnvironmentValues {
    var pinned: PinnedViewModel {
        get { self[PinnedKey.self] }
        set { self[PinnedKey.self] = newValue }
    }
}


struct NewsListView: View {
    @State private var vm = NewsViewModel()
    var category: String? = nil
    var source: String? = nil

    var body: some View {
        Group {
            switch vm.state {
            case .idle: Text("Cargando…")
            case .loading: LoadingView()
            case .failure(let e): ErrorView(message: e.localizedDescription) {
                    Task { await load() }
            }
            case .success:
                List(vm.articles) { a in
                    NavigationLink(value: a) { NewsRowView(article: a) }
                        .swipeActions { Button("Guardar") { PinnedViewModel.shared.add(a) } }
                }
            }
        }
        .navigationTitle(category?.capitalized ?? source ?? "Noticias")
        .task { await load() }
        .navigationDestination(for: Article.self) { a in NewsDetailView(article: a) }
    }

    private func load() async {
        if let c = category {
            await vm.loadCategory(c, country: nil)
        } else if let s = source {
            vm.state = .loading
            do {
                let list = try await NewsService.shared.topHeadlines(query: .init(sources: s))
                vm.articles = list
                vm.state = .success(list)
            } catch { vm.state = .failure(error) }
        } else {
            await vm.loadTop(country: nil)
        }
    }
}

#Preview {
    NavigationStack {
        NewsListView(category: "technology")
    }
}
