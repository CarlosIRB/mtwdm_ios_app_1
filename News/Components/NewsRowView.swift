//
//  NewsRowView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct NewsRowView: View {
    let article: Article
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let s = article.urlToImage, let url = URL(string: s) {
                AsyncImage(url: url) { ph in
                    switch ph {
                    case .empty: ProgressView()
                    case .success(let img): img.resizable().aspectRatio(contentMode: .fill)
                    case .failure: Image(systemName: "photo")
                    @unknown default: EmptyView()
                    }
                }
                .frame(width: 90, height: 60)
                .clipped().cornerRadius(8)
            } else {
                Image(systemName: "newspaper").frame(width: 90, height: 60)
            }

            VStack(alignment: .leading) {
                Text(article.title).font(.headline).lineLimit(2)
                Text(article.source?.name ?? "").font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NewsRowView(
        article: Article(
            source: .init(id: "1", name: "Fuente"),
            author: "Autor",
            title: "Título de ejemplo para la preview",
            description: "Descripción",
            url: "https://example.com",
            urlToImage: Config.genericImage,
            publishedAt: nil,
            content: nil
        )
    )
    .padding()
}
