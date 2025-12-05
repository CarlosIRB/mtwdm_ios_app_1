//
//  NewsAggregatorApp.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

@main
struct NewsAggregatorApp: App {
    @State private var settings = SettingsViewModel.shared
    @State private var pinned = PinnedViewModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settings)
                .environment(pinned)

        }
    }
}
