//
//  HomeConditionView.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import SwiftUI

struct HomeConditionView: View {
    let wheatherData: WeatherData

    var body: some View {
        VStack {
            Image(wheatherData.weatherCurrent.isDay ? "sun" : "moon")
                .resizable()
                .frame(width: 200, height: 200)

            Text(wheatherData.weatherCurrent.condition.text)
                .font(.largeTitle.italic().bold())
                .foregroundColor(getColorFont())
        }
    }

    private func getColorFont() -> Color {
        wheatherData.weatherCurrent.isDay ? .nightColor : .dayColor
    }
}

struct HomeConditionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeConditionView(wheatherData: .mockData)
    }
}
