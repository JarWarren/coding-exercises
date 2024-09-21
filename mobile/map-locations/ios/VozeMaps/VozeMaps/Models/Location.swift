//
//  Location.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation
import MapKit

struct Location: Hashable, Equatable, Identifiable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let type: LocationType
    let name: String
    let description: String
    let estimatedRevenueInMillions: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum LocationType: String, Codable, CaseIterable, Identifiable {
    case bar
    case cafe
    case landmark
    case museum
    case park
    case restaurant
    
    var id: String { rawValue.capitalized }
}
