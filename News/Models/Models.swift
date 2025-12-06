//
//  Models.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]
    let source: [Source]?
}

struct SourcesResponse: Codable {
    let status: String
    let sources: [NewsSourceDTO]
}

struct Article: Codable, Identifiable, Hashable {
    var id: String { url }
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension Article {
    init(fromSource s: NewsSourceDTO) {
        self.source = Source(id: s.id, name: s.name)
        self.author = nil
        self.title = s.description ?? "Title not available"
        self.description = s.description
        self.url = s.url ?? ""
        self.urlToImage = Config.genericImage
        self.publishedAt = nil
        self.content = "\(s.category?.capitalized ?? "General") – \(s.country?.uppercased() ?? "")"
    }
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}

struct NewsSourceDTO: Codable, Identifiable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}

struct Country: Codable, Identifiable {
    var id: String { cca2 }
    let name: Name
    let cca2: String
    let flags: Flags?

    struct Name: Codable { let common: String }
    struct Flags: Codable { let png: String?; let svg: String? }
}
