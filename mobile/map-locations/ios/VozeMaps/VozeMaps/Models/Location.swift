//
//  Location.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation
import MapKit
import SwiftUI

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
    
    var iconName: String {
        switch self {
        case .bar: return "flag.circle.fill"
        case .cafe: return "book.circle.fill"
        case .landmark: return "mountain.2.circle.fill"
        case .museum: return "person.bust.circle.fill"
        case .park: return "tree.circle.fill"
        case .restaurant: return "fork.knife.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .bar: return .brown
        case .cafe: return .red
        case .landmark: return .cyan
        case .museum: return .purple
        case .park: return .green
        case .restaurant: return .orange
        }
    }
}
