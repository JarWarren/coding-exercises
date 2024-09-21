//
//  Routes.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation

/*
 In backend apps, it's common to have a routes file.
 This makes it easy to see the entire API, onboard new devs, and organize the codebase.
 
 iOS developers should adopt it!
 */

enum Routes {
    
    // Representing routes as functions lets us pass in parameters or query items if needed
    
    static func getLocations() -> Route<EmptyPayload, [Location]> {
        return Route(method: .GET, path: "/map-locations/locations.json")
    }
    
//    static func getLocation(id: Int) -> Route<LocationDetail> {
//        return Route(method: .GET, path: "/locations/\(id)")
//    }

//    static func createLocation(_ body: LocationRequestBody) -> Route<LocationResponse, LocationRequestBody> {
//        return Route(method: .POST, path: "/locations", body: body)
//    }

//    static func searchLocations(query: String) -> Route<[Location]> {
//        let queryItems = [URLQueryItem(name: "q", value: query)]
//        return Route(method: .GET, path: "/locations/search", queryItems: queryItems)
//    }
}
