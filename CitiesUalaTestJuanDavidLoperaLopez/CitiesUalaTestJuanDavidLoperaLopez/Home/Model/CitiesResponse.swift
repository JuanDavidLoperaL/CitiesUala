//
//  CitiesResponse.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import Foundation

struct CitiesResponse: Decodable, Identifiable {
    let id: Int
    let name: String
    let country: String
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinates = "coord"
    }
}
