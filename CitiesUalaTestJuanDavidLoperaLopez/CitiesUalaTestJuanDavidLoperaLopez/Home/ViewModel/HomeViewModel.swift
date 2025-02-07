//
//  HomeViewModel.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import Combine
import Foundation

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
                case .failure(let error):
                    self?.state = .error(title: "Error loading data", subtitle: "We got an unexpected error, please try again or contact support juandavidl2011.jdll@gmai.com")
                }
            } receiveValue: { [weak self] citiesList in
                self?.cities = citiesList.sorted {
                    let city1 = "\($0.name), \($0.country)"
                    let city2 = "\($1.name), \($1.country)"
                    return city1.localizedCompare(city2) == .orderedAscending
                }
            }
    }
}
