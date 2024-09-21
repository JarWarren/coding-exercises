//
//  LocationDetailView.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/21/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    let location: Location
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title)
                    .bold()
                HStack {
                    Image(systemName: location.type.iconName)
                        .foregroundColor(location.type.color)
                    Text(location.type.rawValue.capitalized)
                        .font(.headline)
                }
                Text(location.description)
                    .font(.body)
                
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .foregroundColor(.green)
                    Text("Estimated Revenue:")
                        .font(.headline)
                    Text("$\(location.estimatedRevenueInMillions, specifier: "%.1f") million")
                        .font(.body)
                }
            }
            .padding(.vertical, 24)
            
            MapSnapshotView(
                coordinate: location.coordinate,
                imageName: location.type.iconName,
                iconColor: location.type.color
            )
            .frame(height: 200)
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}
