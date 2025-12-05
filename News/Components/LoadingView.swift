//
//  LoadingView.swift
//  News
//
//  Created by Carlos Ismael Ramirez Bello on 05/12/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack { ProgressView(); Text("Cargando…") }
            .padding()
    }
}

#Preview {
    LoadingView()
}
