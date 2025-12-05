//
//  PinnedViewModel.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import Observation
import Foundation

@Observable
final class PinnedViewModel {
    static let shared = PinnedViewModel()

    private let key = "pinnedData"

    var pinned: [Article] = []

    init() {
        pinned = load()
    }

    private func load() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Article].self, from: data)) ?? []
    }

    private func save() {
        let data = (try? JSONEncoder().encode(pinned)) ?? Data()
        UserDefaults.standard.set(data, forKey: key)
    }

    func add(_ a: Article) {
        if !pinned.contains(a) {
            pinned.insert(a, at: 0)
            save()
        }
    }

    func remove(_ a: Article) {
        pinned.removeAll { $0 == a }
        save()
    }
}
