//
//  HomeContentView.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let wheatherData: WeatherData

    var body: some View {
        VStack {
            HomeViewSelector()
            HomeViewHeader(wheatherData: wheatherData)
            Spacer()
            HomeConditionView(wheatherData: wheatherData)
            Spacer()
            HomeViewTempView(selectedTempType: $viewModel.selectedTempType,
                             currentWeather: wheatherData.weatherCurrent)
            Spacer()
        }
        .background(wheatherData.weatherCurrent.isDay ? Color.dayColor : Color.nightColor)
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(wheatherData: .mockData)
            .environmentObject(HomeViewModel())
    }
}
