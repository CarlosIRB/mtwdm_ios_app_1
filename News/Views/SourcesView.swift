//
//  SourcesView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct SourcesView: View {
    @Environment(PinnedViewModel.self) var pinned
    
    var body: some View {
        List {
            Section("Fuentes guardadas") {
                            ForEach(Array(pinned.pinnedSources), id: \.self) { src in
                                NavigationLink(src.capitalized, destination: NewsListView(source: src))
                            }
                        }
        }
        .navigationTitle("Fuentes")
    }
}

#Preview {
    NavigationStack {
        SourcesView().environment(PinnedViewModel.shared)
    }
}
