//
//  HomeViewModelTest.swift
//  CitiesUalaTestJuanDavidLoperaLopezTests
//
//  Created by Juan david Lopera lopez on 7/02/25.
//

import XCTest
import Combine
@testable import CitiesUalaTestJuanDavidLoperaLopez
import SwiftData

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockAPI: MockHomeAPI!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        
        mockAPI = MockHomeAPI(cities: [
            CitiesResponse(id: 1, name: "San Francisco", country: "USA", coordinates: Coordinates(longitude: 0.1, latitude: 0.1), isFavorite: false),
            CitiesResponse(id: 2, name: "New York", country: "USA", coordinates: Coordinates(longitude: 0.2, latitude: 0.2), isFavorite: false),
            CitiesResponse(id: 3, name: "London", country: "UK", coordinates: Coordinates(longitude: 0.3, latitude: 0.3), isFavorite: false)
        ])
        
        viewModel = HomeViewModel(api: mockAPI)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetCitiesSuccess() {
        let expectation = self.expectation(description: "Cities Loaded")

        viewModel.$state
            .sink { state in
                if case .loaded = state {
                    XCTAssertEqual(self.viewModel.cities.count, 3)
                    XCTAssertEqual(self.viewModel.cities.first?.name, "London")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.getCities()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFilterCities() {
        viewModel.getCities()
        
        viewModel.filterBy(city: "San")
        
        XCTAssertEqual(viewModel.cities.count, 1)
        XCTAssertEqual(viewModel.cities.first?.name, "San Francisco")
    }
    
    func testToggleFavorite() {
        viewModel.getCities()
        
        let cityToToggle = viewModel.cities.first { $0.name == "San Francisco" }
        
        XCTAssertFalse(cityToToggle?.isFavorite ?? true)
        
        viewModel.toggleFavorite(for: cityToToggle!, completionHandler: { index in
            XCTAssertTrue(self.viewModel.cities[index].isFavorite)
        })
    }
    
    func testLoadFavoritesCities() {
        let favoriteCity = City(id: 1,name: "San Francisco", country: "USA", isFavorite: false)
        
        viewModel.set(favoritesCities: [favoriteCity])
        
        viewModel.getCities()
        
        XCTAssertTrue(viewModel.cities.first { $0.name == "San Francisco" }?.isFavorite ?? false)
    }
}
