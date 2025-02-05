//
//  CitiesUalaTestJuanDavidLoperaLopezApp.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import SwiftUI

@main
struct CitiesUalaTestJuanDavidLoperaLopezApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(api: HomeAPI(baseURL: "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json")))
        }
    }
}
