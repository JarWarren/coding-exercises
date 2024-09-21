//
//  MapSnapshotView.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/21/24.
//

import MapKit
import SwiftUI

struct MapSnapshotView: View {
    let coordinate: CLLocationCoordinate2D
    let imageName: String
    let iconColor: Color
    @State private var snapshotImage: UIImage? = nil
    
    var body: some View {
        Group {
            if let image = snapshotImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        fetchSnapshot()
                    }
            }
        }
    }
    
    /// Probably overkill. Grabs a snapshot of the map at the given coordinate and adds an annotation image in the middle.
    func fetchSnapshot() {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        options.size = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        options.scale = UIScreen.main.scale

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot else {
                print("Snapshot error: \(String(describing: error))")
                return
            }

            UIGraphicsBeginImageContextWithOptions(options.size, true, options.scale)
            snapshot.image.draw(at: .zero)

            _ = UIGraphicsGetCurrentContext()

            let pinImage = UIImage(systemName: imageName)?.withTintColor(.init(iconColor), renderingMode: .alwaysOriginal)

            let point = snapshot.point(for: coordinate)

            let pinCenterOffset = CGPoint(x: (pinImage?.size.width ?? 0) / 2, y: (pinImage?.size.height ?? 0))
            let pinPoint = CGPoint(x: point.x - pinCenterOffset.x, y: point.y - pinCenterOffset.y)

            pinImage?.draw(at: pinPoint)

            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            DispatchQueue.main.async {
                self.snapshotImage = finalImage
            }
        }
    }
}

