//
//  LocationDetailView.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/21/24.
//

import SwiftUI

struct LocationDetailView: View {
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.name)
                .font(.largeTitle)
                .bold()
            Text("Type: \(location.type.rawValue.capitalized)")
            Text("Description: \(location.description)")
            Text("Estimated Revenue: $\(location.estimatedRevenueInMillions, specifier: "%.2f") million")
            Spacer()
        }
        .padding()
    }
}
