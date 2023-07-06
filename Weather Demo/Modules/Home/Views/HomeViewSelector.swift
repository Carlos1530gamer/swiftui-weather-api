//
//  HomeViewSelector.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import SwiftUI

struct HomeViewSelector: View {
    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        Picker("Choise City", selection: $viewModel.selectedCity) {
            Text("London").tag(City.london)
            Text("Mexico City").tag(City.mexicoCity)
            Text("Paris").tag(City.paris)
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.selectedCity) { _ in
            viewModel.getWeatherData()
        }
    }
}

struct HomeViewNavigation_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSelector()
            .environmentObject(HomeViewModel())
    }
}
