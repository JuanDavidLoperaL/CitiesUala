//
//  City.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 7/02/25.
//

import Foundation
import SwiftData

@Model
class City {
    @Attribute(.unique)
    var id: Int
    var name: String
    var country: String
    var isFavorite: Bool = false
    
    init(id: Int, name: String, country: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.country = country
        self.isFavorite = isFavorite
    }
}
