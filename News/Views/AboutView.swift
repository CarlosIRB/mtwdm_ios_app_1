//
//  AboutView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("News Aggregator").font(.title2).bold()
            Text("Proyecto iOS con SwiftUI, MVVM, APIs y persistencia local.")
            Text("APIs usadas:")
            Text("• News API\n• REST Countries API\n• Random Word API")
            Spacer()
        }
        .padding()
        .navigationTitle("Acerca de")
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
