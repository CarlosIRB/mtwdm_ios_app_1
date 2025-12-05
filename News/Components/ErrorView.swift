//
//  ErrorView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retry: () -> Void
    var body: some View {
        ContentUnavailableView {
            Label("Error", systemImage: "exclamationmark.triangle")
        } description: { Text(message) } actions: {
            Button("Reintentar", action: retry)
        }
    }
}

#Preview {
    ErrorView(message: "Error de ejemplo") { }
}
