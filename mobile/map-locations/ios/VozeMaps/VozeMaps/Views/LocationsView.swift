//
//  LocationsView.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @StateObject var vm = LocationsVM()
    @State var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: sanFrancisco, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
    static let sanFrancisco = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    
    
    var filteredLocations: [Location] {
        guard let selected = vm.selectedType else { return vm.locations }
        return vm.locations.filter { $0.type == selected }
    }
    
    var body: some View {
        VStack {
            Picker("Location Type", selection: $vm.state.selectedType) {
                ForEach(LocationType.allCases) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
                Text("All").tag(LocationType?.none)
            }
            .pickerStyle(.menu)
            .padding()
            
            Map(position: $cameraPosition, interactionModes: [.all]) {
                ForEach(filteredLocations, id: \.id) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        LocationMarker(location: location) {
                            vm.state.selectedLocation = location
                        }
                    }
                    .annotationTitles(.visible)
                }
            }
            .mapStyle(
                .standard(
                    elevation: .automatic,
                    emphasis: .automatic,
                    pointsOfInterest: .excludingAll,
                    showsTraffic: false
                )
            )
            .edgesIgnoringSafeArea(.all)
            .sheet(item: $vm.state.selectedLocation) { location in
                LocationDetailView(location: location)
            }
            .task {
                await vm.getLocations()
            }
        }
    }
}

#Preview {
    LocationsView()
}
