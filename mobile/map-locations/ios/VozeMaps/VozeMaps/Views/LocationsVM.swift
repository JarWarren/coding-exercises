//
//  LocationsVM.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation

class LocationsVM: ViewModel {
    @Published var state = State()
    let network = Networking()
    
    // State exists on a single struct, rather than spread out accross publishers
    struct State: Hashable {
        var locations = [Location]()
    }
    
    @MainActor
    func getLocations() async throws {
        let locations: [Location] = try await network.perform(Routes.getLocations())
        update { $0.locations = locations }
    }
}
