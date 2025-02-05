//
//  HomeViewModel.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    
    // MARK: - Private Properties
    private let api: HomeAPIProtocol
    private var cancellable: AnyCancellable?
    
    // MARK: - Internal Init
    init(api: HomeAPIProtocol = HomeAPI()) {
        self.api = api
    }
    
    // MARK: - Published
    @Published var cities: [CitiesResponse] = [CitiesResponse]()
    @Published var isLoading: Bool = false
}

// MARK: - Internal Functions
extension HomeViewModel {
    func getCities() {
        isLoading = true
        cancellable = api.getCities()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] citiesList in
                print(citiesList)
                self?.cities = citiesList
            }
    }
}
