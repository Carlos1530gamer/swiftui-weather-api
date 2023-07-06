//
//  HomeView.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 05/07/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = .init()

    var body: some View {
        NavigationStack {
            VStack {
                if let data = viewModel.wheatherData {
                    HomeContentView(wheatherData: data)
                } else {
                    HomeViewLoader()
                }
            }
        }
        .environmentObject(viewModel)
        .onAppear(perform: viewModel.getWeatherData)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
