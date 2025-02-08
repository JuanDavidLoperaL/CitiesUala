//
//  CityCell.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 6/02/25.
//

import SwiftUI
import SwiftData

struct CityCell: View {
    
    // MARK: - Environment Properties
    @Environment(\.modelContext) private var modelContext
    @Query private var favoritesCities: [City]
    
    // MARK: - Observed Properties
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - Private Properties
    private let city: CitiesResponse
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel, city: CitiesResponse) {
        self.viewModel = viewModel
        self.city = city
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(city.name), \(city.country.uppercased())")
                Text("Latitud: \(city.coordinates.latitude)")
                Text("Longitud: \(city.coordinates.longitude)")
            }
            Spacer()
            Button {
                viewModel.toggleFavorite(for: city, in: modelContext, completionHandler: { index in
                    if viewModel.cities[index].isFavorite {
                        let saveCity: City = City(id: city.id, name: city.name, country: city.country, isFavorite: city.isFavorite)
                        do {
                            modelContext.insert(saveCity)
                            try modelContext.save()
                        } catch {
                            print("Error saving city in local database")
                        }
                    } else {
                        do {
                            modelContext.delete(favoritesCities.first(where: { cityDelete in
                                return cityDelete.id == viewModel.cities[index].id
                            }) ?? favoritesCities[0])
                            try modelContext.save()
                        } catch {
                            print("Error Deleting city in local database")
                        }
                    }
                })
            } label: {
                Image(city.isFavorite ? "favorite" : "favorite_not_filled")
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2)
    }
}

