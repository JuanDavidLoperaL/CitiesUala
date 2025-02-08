//
//  HomeView.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @Query private var favoritesCities: [City]
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchText: String = ""
    
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
                    TextField("Buscar ciudad...", text: $searchText)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: searchText) { newValue in
                            viewModel.filterBy(city: newValue)
                        }
                        .padding(.top)
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.cities, id: \.id) { city in
                                CityCell(viewModel: viewModel, city: city)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Ciudades")
            .onAppear {
                viewModel.set(favoritesCities: favoritesCities)
                viewModel.getCities()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
