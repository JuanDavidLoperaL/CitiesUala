//
//  HomeAPI.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import Combine
import Foundation

protocol HomeAPIProtocol: AnyObject {
    func getCities() -> AnyPublisher<[CitiesResponse], Error>
}

final class HomeAPI: HomeAPIProtocol {
    
    // MARK: - Private Properties
    private let baseURL: String
    
    // MARK: - Internal Init
    init(baseURL: String = "") {
        self.baseURL = baseURL
    }
    
    func getCities() -> AnyPublisher<[CitiesResponse], any Error> {
        guard let url: URL = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
                    throw URLError(.badServerResponse)
                }
                do {
                    let cities: [CitiesResponse] = try JSONDecoder().decode([CitiesResponse].self, from: data)
                    return cities
                } catch {
                    throw error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
