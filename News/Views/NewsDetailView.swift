//
//  NewsDetailView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct NewsDetailView: View {
    let article: Article
    @Environment(\.pinned) var pinned

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let s = article.urlToImage, let url = URL(string: s) {
                    AsyncImage(url: url) { ph in
                        switch ph {
                        case .empty: ProgressView()
                        case .success(let img): img.resizable().aspectRatio(contentMode: .fill)
                        case .failure: Image(systemName: "photo")
                        @unknown default: EmptyView()
                        }
                    }
                    .frame(width: 400, height: 220)
                    .clipped()
                }

                Text(article.title).font(.title2).bold()
                Text(article.source?.name ?? "").font(.caption).foregroundStyle(.secondary)

                if let c = article.content ?? article.description {
                    Text(c)
                }

                if let u = URL(string: article.url) {
                    Link("Leer en la fuente", destination: u).padding(.top)
                }
            }
            .padding()
        }
        .toolbar {
            Button {
                if pinned.isPinned(article) {
                    pinned.remove(article)
                } else {
                    pinned.add(article)
                }
            } label: {
                Image(systemName: pinned.isPinned(article) ? "bookmark.fill" : "bookmark")
            }
            if let sourceName = article.source?.id {
                Button {
                    if pinned.isSourcePinned(sourceName) {
                        pinned.removeSource(sourceName)
                    } else {
                        pinned.addSource(sourceName)
                    }
                } label: {
                    Image(systemName: pinned.isSourcePinned(sourceName) ? "star.fill" : "star")
                }
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NewsDetailView(
            article: Article(
                source: .init(id: "test", name: "Preview Source"),
                author: "Autor",
                title: "Título de ejemplo",
                description: "Descripción breve.",
                url: "https://example.com",
                urlToImage: nil,
                publishedAt: nil,
                content: "Contenido del artículo de prueba para la vista previa."
            )
        )
        .environment(PinnedViewModel.shared)
    }
}
