//
//  HomeAPIMock.swift
//  CitiesUalaTestJuanDavidLoperaLopezTests
//
//  Created by Juan david Lopera lopez on 7/02/25.
//

import Combine
import Foundation
@testable import CitiesUalaTestJuanDavidLoperaLopez

class MockHomeAPI: HomeAPIProtocol {
    var cities: [CitiesResponse] = []
    
    init(cities: [CitiesResponse] = []) {
        self.cities = cities
    }
    
    func getCities() -> AnyPublisher<[CitiesResponse], Error> {
        Just(cities)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
