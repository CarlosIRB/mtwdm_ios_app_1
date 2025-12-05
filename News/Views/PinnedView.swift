//
//  PinnedView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct PinnedView: View {
    @Environment(PinnedViewModel.self) var pinned

    var body: some View {
        List {
            if pinned.pinned.isEmpty { Text("No hay artículos guardados") }
            ForEach(pinned.pinned) { a in
                NavigationLink(value: a) { NewsRowView(article: a) }
                    .swipeActions { Button("Eliminar", role: .destructive) { pinned.remove(a) } }
            }
        }
        .navigationTitle("Guardados")
        .navigationDestination(for: Article.self) { a in NewsDetailView(article: a) }
        
        NavigationLink("Fuentes", destination: SourcesView())
    }
    
    
}

#Preview {
    NavigationStack {
        PinnedView()
            .environment(PinnedViewModel.shared)
    }
}
