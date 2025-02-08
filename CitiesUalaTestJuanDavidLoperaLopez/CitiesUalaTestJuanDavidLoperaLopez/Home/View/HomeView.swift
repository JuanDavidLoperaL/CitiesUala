//
//  HomeView.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @Query private var favoritesCities: [City]
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchText: String = ""
    @State private var region: MKCoordinateRegion
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    switch viewModel.state {
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(2)
                            .padding()
                        Text("Cargando...")
                    case .error(let title, let subtitle):
                        Text(title)
                        Text(subtitle)
                    case .loaded:
                        TextField("Buscar ciudad...", text: $searchText)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: searchText) { newValue in
                                viewModel.filterBy(city: newValue)
                            }
                            .padding(.top)
                        if geometry.size.height > geometry.size.width {
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 10) {
                                    ForEach(viewModel.cities, id: \.id) { city in
                                        NavigationLink(destination: MapView(lat: city.coordinates.latitude, long: city.coordinates.longitude)) {
                                            CityCell(viewModel: viewModel, city: city)
                                        }
                                    }
                                }
                                .padding()
                            }
                        } else {
                            if !viewModel.cities.isEmpty {
                                ScrollView {
                                    HStack {
                                        LazyVStack(alignment: .leading, spacing: 10) {
                                            ForEach(viewModel.cities, id: \.id) { city in
                                                CityCell(viewModel: viewModel, city: city)
                                            }
                                        }
                                        .padding()
//                                        let firstCity = viewModel.cities.first
//                                        let latitude = firstCity?.coordinates.latitude ?? 0.0
//                                        let longitude = firstCity?.coordinates.longitude ?? 0.0
//                                        Map(coordinateRegion: $region, annotationItems: [Location(latitude: latitude, longitude: longitude)]) { location in
//                                            MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
//                                        }
//                                        .edgesIgnoringSafeArea(.all)
                                        Text("Mapa dando error: An abort signal terminated the process. Such crashes often happen because of an uncaught exception or unrecoverable error or calling the abort() function.")
                                    }
                                }
                            } else {
                                EmptyView()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Ciudades")
                .task {
                    viewModel.set(favoritesCities: favoritesCities)
                    viewModel.getCities()
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
