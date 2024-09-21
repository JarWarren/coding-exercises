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
        ZStack {
            mapView
            fabView
        }
        .sheet(item: $vm.state.selectedLocation) { location in
            LocationDetailView(location: location)
        }
        .task {
            await vm.getLocations()
        }
    }
    
    var mapView: some View {
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
    }
    
    var fabView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Menu {
                    fabButtonView("All", isSelected: vm.state.selectedType == nil) {
                        vm.state.selectedType = nil
                    }
                    
                    ForEach(LocationType.allCases, id: \.self) { type in
                        fabButtonView(type.rawValue.capitalized, isSelected: vm.state.selectedType == type) {
                            vm.state.selectedType = type
                        }
                    }
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black.opacity(0.6))
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
        }
    }
    
    func fabButtonView(_ label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            if isSelected {
                Label(label, systemImage: "checkmark")
            } else {
                Text(label)
            }
        }
    }
}

#Preview {
    LocationsView()
}
