//
//  CityCell.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 6/02/25.
//

import SwiftUI

struct CityCell: View {
    
    // MARK: - Private Properties
    private let city: CitiesResponse
    
    // MARK: - Internal Init
    init(city: CitiesResponse) {
        self.city = city
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(city.name), \(city.country.uppercased())")
            Text("Latitud: \(city.coordinates.latitude)")
            Text("Longitud: \(city.coordinates.longitude)")
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
    CityCell(city: CitiesResponse(id: 0, name: "Medellin", country: "COL", coordinates: Coordinates(longitude: 1.0, latitude: 1.0)))
}
