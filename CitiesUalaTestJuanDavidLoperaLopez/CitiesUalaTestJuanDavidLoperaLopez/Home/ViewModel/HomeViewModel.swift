//
//  HomeViewModel.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import Combine
import Foundation
import SwiftData

final class HomeViewModel: ObservableObject {
    
    // MARK: - Enum
    enum State {
        case loading
        case loaded
        case error(title: String, subtitle: String)
    }
    
    // MARK: - Private Properties
    private let api: HomeAPIProtocol
    private var cancellable: AnyCancellable?
    private var originalCitiesList: [CitiesResponse] = [CitiesResponse]()
    private var favoriteCities: [City] = []
    
    // MARK: - Internal Init
    init(api: HomeAPIProtocol = HomeAPI()) {
        self.api = api
    }
    
    // MARK: - Published
    @Published var cities: [CitiesResponse] = [CitiesResponse]()
    @Published var state: State = .loading
}

// MARK: - Internal Functions
extension HomeViewModel {
    func getCities() {
        state = .loading
        cancellable = api.getCities()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .loaded
                case .failure:
                    self?.state = .error(title: "Error loading data", subtitle: "We got an unexpected error, please try again or contact support juandavidl2011.jdll@gmai.com")
                }
            } receiveValue: { [weak self] citiesList in
                self?.originalCitiesList = citiesList.sorted {
                    let city1 = "\($0.name), \($0.country)"
                    let city2 = "\($1.name), \($1.country)"
                    return city1.localizedCompare(city2) == .orderedAscending
                }
                self?.loadFavoritesCities()
                self?.cities = self?.originalCitiesList ?? []
            }
    }
    
    func filterBy(city: String) {
        if city.isEmpty {
            cities = originalCitiesList
        } else {
            cities = originalCitiesList.filter({ cities in
                return cities.name.lowercased().contains(city.lowercased())
            })
        }
    }
    
    func toggleFavorite(for city: CitiesResponse, in modelContext: ModelContext, completionHandler: @escaping(_ index: Int) ->Void) {
        var position: Int = 0
        if let index = cities.firstIndex(where: { $0.id == city.id }) {
            cities[index].isFavorite.toggle()
        }
        if let index = originalCitiesList.firstIndex(where: { $0.id == city.id }) {
            originalCitiesList[index].isFavorite.toggle()
            position = index
        }
        completionHandler(position)
    }
    
    func set(favoritesCities: [City]) {
        self.favoriteCities = favoritesCities
    }
}

// MARK: - Private Functions
private extension HomeViewModel {
    func loadFavoritesCities() {
        for (index, item) in originalCitiesList.enumerated() {
            if favoriteCities.contains(where: { city in
                return city.name == item.name
            }) {
                originalCitiesList[index].isFavorite = true
            }
        }
    }
}
