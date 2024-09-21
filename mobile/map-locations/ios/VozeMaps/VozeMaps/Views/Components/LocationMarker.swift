//
//  LocationMarker.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/21/24.
//

import MapKit
import SwiftUI

struct LocationMarker: View {
    let location: Location
    let onSelected: () -> Void
    
    var body: some View {
        Button(action: onSelected) {
            Image(systemName: iconForLocationType(location.type))
                .foregroundColor(colorForLocationType(location.type))
                .font(.title)
                .background(
                    Circle().fill(Color.black.opacity(0.8))
                )
        }
        .font(.title)
    }
    
    func colorForLocationType(_ type: LocationType) -> Color {
        switch type {
        case .bar: return .brown
        case .cafe: return .red
        case .landmark: return .cyan
        case .museum: return .purple
        case .park: return .green
        case .restaurant: return .orange
        }
    }
    
    func iconForLocationType(_ type: LocationType) -> String {
        switch type {
        case .bar: return "flag.circle.fill"
        case .cafe: return "book.circle.fill"
        case .landmark: return "mountain.2.circle.fill"
        case .museum: return "person.bust.circle.fill"
        case .park: return "tree.circle.fill"
        case .restaurant: return "fork.knife.circle.fill"
        }
    }
}
