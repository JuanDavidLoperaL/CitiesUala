//
//  HomeView.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
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
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(Array(viewModel.cities.enumerated()), id: \.element.id) { index, city in
                                CityCell(viewModel: viewModel, index: index)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Ciudades")
            .onAppear {
                viewModel.getCities()
            }
        }
    }
}

struct CityCell: View {
    
    // MARK: - Properties
    @StateObject var viewModel: HomeViewModel
    
    // MARK: - Private Properties
    private let index: Int
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel, index: Int) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.index = index
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.cities[index].name), \(viewModel.cities[index].country.uppercased())")
            Text("Latitud: \(viewModel.cities[index].coordinates.latitude) - Longitud: \(viewModel.cities[index].coordinates.longitude)")
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2)
    }
}
#Preview {
    HomeView(viewModel: HomeViewModel())
}
