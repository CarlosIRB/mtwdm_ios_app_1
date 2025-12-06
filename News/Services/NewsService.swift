//
//  NewsService.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Foundation

struct NewsQuery {
    var country: String? = nil
    var category: String? = nil
    var sources: String? = nil
    var q: String? = nil
    var page: Int = 1
    var pageSize: Int = 20
}

final class NewsService {
    static let shared = NewsService()
    private init() {}
    
    
    func unifiedTopHeadlines(query: NewsQuery) async throws -> [Article] {
            
            // Si es US → endpoint normal
            if query.country?.lowercased() == "us" {
                return try await topHeadlines(query: query)
            }
            
            // Si es otro país → usar sources y convertir
            let sources = try await topHeadlinesFromSource(query: query)
            
            // Convertir cada source a Article híbrido
            return sources.map { Article(fromSource: $0) }
        }

    func topHeadlinesFromSource(query: NewsQuery) async throws -> [NewsSourceDTO] {
        var c = URLComponents(string: Config.newsBaseURL + "/top-headlines/sources")
        var items = [URLQueryItem(name: "apiKey", value: Config.newsAPIKey)]
        if let v = query.country { items.append(.init(name: "country", value: v)) }
        if let v = query.category { items.append(.init(name: "category", value: v)) }
        c?.queryItems = items
        guard let url = c?.url else { throw NetworkError.invalidURL }
        
        let r: SourcesResponse = try await NetworkService.shared.request(url: url)
        return r.sources
    }
    
    func topHeadlines(query: NewsQuery) async throws -> [Article] {
        var c = URLComponents(string: Config.newsBaseURL + "/top-headlines")
        var items = [URLQueryItem(name: "apiKey", value: Config.newsAPIKey)]
        if let v = query.country { items.append(.init(name: "country", value: v)) }
        if let v = query.category { items.append(.init(name: "category", value: v)) }
        c?.queryItems = items
        guard let url = c?.url else { throw NetworkError.invalidURL }
        
        let r: NewsResponse = try await NetworkService.shared.request(url: url)
        return r.articles
    }

    func everything(_ text: String) async throws -> [Article] {
        var c = URLComponents(string: Config.newsBaseURL + "/everything")
        c?.queryItems = [
            .init(name: "apiKey", value: Config.newsAPIKey),
            .init(name: "q", value: text)
        ]
        guard let url = c?.url else { throw NetworkError.invalidURL }
        let r: NewsResponse = try await NetworkService.shared.request(url: url)
        return r.articles
    }
}
