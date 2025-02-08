//
//  MapView.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 7/02/25.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView: View {
    
    // MARK: - State Properties
    @State private var region: MKCoordinateRegion
    
    // MARK: - Private Properties
    private let lat: CLLocationDegrees
    private let long: CLLocationDegrees
    
    // MARK: - Internal Init
    init(lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.lat = lat
        self.long = long
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: long),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [Location(latitude: lat, longitude: long)]) { location in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Location: Identifiable {
    let id = UUID()  // Identificador único
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

#Preview {
    MapView(lat: 4.5709, long: 74.2973)
}
