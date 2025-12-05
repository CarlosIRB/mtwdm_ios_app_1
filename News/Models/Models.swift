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

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}

struct Country: Codable, Identifiable {
    var id: String { cca2 }
    let name: Name
    let cca2: String
    let flags: Flags?

    struct Name: Codable { let common: String }
    struct Flags: Codable { let png: String?; let svg: String? }
}
