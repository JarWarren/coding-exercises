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
    
    // Important state (user selections, the values they type into textfields, etc) need to live on a VM, ready to be sent elsewhere in the app
    
    // Uninteresting state (how far the user has scrolled, whether they have zoomed in) can live on the view and be forgotten
    
    // It exists on a single struct both for clarity and performance
    // (being a single struct means we can batch updates to the UI)
    struct State: Hashable {
        var locations = [Location]()
        var selectedLocation: Location?
        var selectedType: LocationType?
        var errorMessage: String?
    }
    
    @MainActor
    func getLocations() async {
        do {
            let locations: [Location] = try await network.perform(Routes.getLocations())
            update { $0.locations = locations }
        } catch {
            update { $0.errorMessage = error.localizedDescription }
        }
    }
}
