//
//  HomeViewHeader.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import SwiftUI

struct HomeViewHeader: View {
    let wheatherData: WeatherData

    var body: some View {
        VStack {
            Text(wheatherData.location.name)
                .font(.largeTitle.italic().bold())
                .foregroundColor(getColorFont())

            Text(wheatherData.location
                .localtime
                .getFormattedDate(timeZone: wheatherData.location.tzID))
                .font(.body)
                .foregroundColor(getColorFont())
        }
    }

    private func getColorFont() -> Color {
        wheatherData.weatherCurrent.isDay ? .nightColor : .dayColor
    }
}

struct HomeViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewHeader(wheatherData: .mockData)
    }
}
