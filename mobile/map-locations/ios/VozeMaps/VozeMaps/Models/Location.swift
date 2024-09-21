//
//  Location.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

struct Location: Hashable, Equatable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let type: LocationType
    let name: String
    let description: String
    let estimatedRevenueInMillions: Double
}

enum LocationType: String, Codable {
    case bar
    case cafe
    case landmark
    case museum
    case park
    case restaurant
}
