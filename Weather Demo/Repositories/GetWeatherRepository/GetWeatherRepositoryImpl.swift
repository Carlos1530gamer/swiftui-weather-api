//
//  GetWeatherRepositoryImpl.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import Foundation

final class GetWeatherRepositoryImpl: BaseNetworking, GetWeatherRepositoryProtocol {
    func getWeather(from location: String) async -> Result<WeatherData, Error> {
        await makeRequest(querys: [
            "q": location
        ])
    }
}
