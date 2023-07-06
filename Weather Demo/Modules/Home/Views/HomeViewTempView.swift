//
//  HomeViewTempView.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import SwiftUI

struct HomeViewTempView: View {
    @Binding var selectedTempType: TempType
    let currentWeather: WeatherCurrent

    var body: some View {
        Picker("Choise Temp Type", selection: $selectedTempType) {
            Text("Celcius").tag(TempType.celcius)
            Text("fahrenheit").tag(TempType.fahrenheit)
        }
        .pickerStyle(.segmented)
        .frame(width: 200)

        switch selectedTempType {
        case .celcius: makeCelciusView()
        case .fahrenheit: makeFahrenheitView()
        }
    }

    @ViewBuilder
    func makeCelciusView() -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(String(currentWeather.celciusTemp))
                .font(.system(size: 50).bold())
                .foregroundColor(getColorFont())

            Text("°C")
                .font(.title.italic())
                .foregroundColor(getColorFont())
        }
    }

    @ViewBuilder
    func makeFahrenheitView() -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(String(currentWeather.fahrenheitTemp))
                .font(.system(size: 50).bold())
                .foregroundColor(getColorFont())

            Text("°F")
                .font(.title.italic())
                .foregroundColor(getColorFont())
        }
    }

    private func getColorFont() -> Color {
        currentWeather.isDay ? .nightColor : .dayColor
    }
}

struct HomeViewTempTypeSelector_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeViewTempView(selectedTempType: .constant(.celcius),
                             currentWeather: WeatherData.mockData.weatherCurrent)
            HomeViewTempView(selectedTempType: .constant(.fahrenheit),
                             currentWeather: WeatherData.mockData.weatherCurrent)
        }
    }
}
