//
//  SourcesView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct SourcesView: View {
    var body: some View {
        List {
            NavigationLink("BBC News", destination: NewsListView(source: "bbc-news"))
        }
        .navigationTitle("Fuentes")
    }
}

#Preview {
    NavigationStack {
        SourcesView()
    }
}
