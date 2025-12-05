//
//  NewsViewModel.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Observation
import Foundation

@Observable
final class NewsViewModel {
    var articles: [Article] = []
    var state: LoadingState<[Article]> = .idle
    var selectedCategory: String? = nil
    var selectedCountry: String? = nil

    @MainActor
    func loadTop(country: String?) async {
        state = .loading
        do {
            let list = try await NewsService.shared.topHeadlines(query: .init(country: country))
            articles = list
            state = .success(list)
        } catch { state = .failure(error) }
    }

    @MainActor
    func loadCategory(_ cat: String, country: String?) async {
        state = .loading
        do {
            let list = try await NewsService.shared.topHeadlines(query: .init(country: country, category: cat))
            articles = list
            state = .success(list)
        } catch { state = .failure(error) }
    }

    @MainActor
    func search(_ text: String) async {
        state = .loading
        do {
            let list = try await NewsService.shared.everything(text)
            articles = list
            state = .success(list)
        } catch { state = .failure(error) }
    }
}
