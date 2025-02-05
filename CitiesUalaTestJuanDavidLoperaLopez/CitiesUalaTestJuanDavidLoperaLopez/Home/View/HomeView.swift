//
//  HomeView.swift
//  CitiesUalaTestJuanDavidLoperaLopez
//
//  Created by Juan david Lopera lopez on 5/02/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                viewModel.getCities()
            }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
