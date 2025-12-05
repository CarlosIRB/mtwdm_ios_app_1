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
    private let keySources = "pinnedSources"

    var pinned: [Article] = []
    var pinnedSources: Set<String> = []

    init() {
        pinned = load()
        pinnedSources = loadSources()
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
        if !pinned.contains(where: { $0.url == a.url }) {
            pinned.insert(a, at: 0)
            save()
        }
    }

    func remove(_ a: Article) {
        pinned.removeAll { $0.url == a.url }
        save()
    }
    
    func isPinned(_ a: Article) -> Bool {
        pinned.contains(where: { $0.url == a.url })
    }
    
    private func loadSources() -> Set<String> {
        let arr = UserDefaults.standard.stringArray(forKey: keySources) ?? []
        return Set(arr)
    }

    private func saveSources() {
        UserDefaults.standard.set(Array(pinnedSources), forKey: keySources)
    }

    func addSource(_ sourceID: String) {
        pinnedSources.insert(sourceID)
        saveSources()
    }

    func removeSource(_ sourceID: String) {
        pinnedSources.remove(sourceID)
        saveSources()
    }

    func isSourcePinned(_ sourceID: String) -> Bool {
        pinnedSources.contains(sourceID)
    }
}
