//
//  GetWeatherRepositoryProtocol.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import Foundation

protocol GetWeatherRepositoryProtocol {
    func getWeather(from location: String) async -> Result<WeatherData, Error>
}
