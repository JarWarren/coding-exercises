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
            Image(systemName: location.type.iconName)
                .foregroundColor(location.type.color)
                .font(.title)
                .background(
                    Circle().fill(Color.black.opacity(0.8))
                )
        }
        .font(.title)
    }
}
