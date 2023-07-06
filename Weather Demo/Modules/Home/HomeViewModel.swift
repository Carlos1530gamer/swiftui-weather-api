//
//  HomeViewModel.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var wheatherData: WeatherData?
    @Published var selectedCity: City = .london
    @Published var selectedTempType: TempType = .celcius
    private var getWeatherRepo: GetWeatherRepositoryProtocol

    init(getWeatherRepo: GetWeatherRepositoryProtocol = GetWeatherRepositoryImpl()) {
        self.getWeatherRepo = getWeatherRepo
    }

    func getWeatherData() {
        Task.detached { [weak self] in
            await self?.getWheater()
        }
    }

    @MainActor private func getWheater() async {
        let result = await getWeatherRepo.getWeather(from: selectedCity.rawValue)

        switch result {
        case .success(let success):
            wheatherData = success
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
        }
    }
}
