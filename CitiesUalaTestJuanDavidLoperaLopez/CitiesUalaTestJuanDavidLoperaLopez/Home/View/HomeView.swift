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

#Preview {
    HomeView(viewModel: HomeViewModel())
}
