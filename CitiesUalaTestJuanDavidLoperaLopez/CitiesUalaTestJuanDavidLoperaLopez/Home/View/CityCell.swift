//
//  CityCell.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 6/02/25.
//

import SwiftUI

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
    CityCell(viewModel: HomeViewModel(), index: 0)
}
