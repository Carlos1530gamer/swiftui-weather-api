//
//  WeatherData.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 05/07/23.
//

import Foundation

// MARK: - WeatherData

struct WeatherData: Decodable {
    let location: WeatherLocation
    let weatherCurrent: WeatherCurrent

    enum CodingKeys: String, CodingKey {
        case location
        case weatherCurrent = "current"
    }

    #if DEBUG
    static let mockData = WeatherData(location: .init(name: "Mexico City",
                                                      region: "The Federal District",
                                                      country: "Mexico",
                                                      tzID: "America/Mexico_City",
                                                      localtime: .now),
                                      weatherCurrent: .init(celciusTemp: 19,
                                                            fahrenheitTemp: 66.2,
                                                            isDay: true,
                                                            condition: .init(text: "Overcast",
                                                                             icon: "",
                                                                             code: 100)))
    #endif
}

// MARK: - WeatherCurrent

struct WeatherCurrent: Decodable {
    let celciusTemp: Int
    let fahrenheitTemp: Double
    let isDay: Bool
    let condition: WeatherCondition

    enum CodingKeys: String, CodingKey {
        case celciusTemp = "temp_c"
        case fahrenheitTemp = "temp_f"
        case isDay = "is_day"
        case condition
    }

    init(celciusTemp: Int, fahrenheitTemp: Double, isDay: Bool, condition: WeatherCondition) {
        self.celciusTemp = celciusTemp
        self.fahrenheitTemp = fahrenheitTemp
        self.isDay = isDay
        self.condition = condition
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.celciusTemp = try container.decode(Int.self, forKey: .celciusTemp)
        self.fahrenheitTemp = try container.decode(Double.self, forKey: .fahrenheitTemp)
        self.isDay = try container.decode(Int.self, forKey: .isDay) == 1
        self.condition = try container.decode(WeatherCondition.self, forKey: .condition)
    }
}

// MARK: - WeatherCondition

struct WeatherCondition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

// MARK: - WeatherLocation

struct WeatherLocation: Decodable {
    let name, region, country, tzID: String
    let localtime: Date

    enum CodingKeys: String, CodingKey {
        case name, region, country
        case tzID = "tz_id"
        case localtime = "localtime_epoch"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.region = try container.decode(String.self, forKey: .region)
        self.country = try container.decode(String.self, forKey: .country)
        self.tzID = try container.decode(String.self, forKey: .tzID)
        let localEpochTime = try container.decode(Int.self, forKey: .localtime)
        self.localtime = Date(timeIntervalSince1970: TimeInterval(localEpochTime))
    }

    init(name: String, region: String, country: String, tzID: String, localtime: Date) {
        self.name = name
        self.region = region
        self.country = country
        self.tzID = tzID
        self.localtime = localtime
    }
}
