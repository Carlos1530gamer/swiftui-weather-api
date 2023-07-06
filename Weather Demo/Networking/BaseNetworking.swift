//
//  BaseNetworking.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 05/07/23.
//

import SwiftUI

enum EnviromentData {
    static let baseUrl: String = "https://api.weatherapi.com/v1/current.json?key=9745357b64764a1c926173930223105&="
}

protocol BaseNetworking {}

enum BaseNetworkingError: Error {
    case cantCreateUrl
    case unauthorized
    case unexpectedStatusCode
    case noResponse
}

enum BaseNetworkingMethod: String {
    case get = "GET"
    case post = "POST"
}

extension BaseNetworking {
    func makeRequest<T: Decodable>(airQuality: Bool = false,
                                   querys: [String: String],
                                   httpMethod: BaseNetworkingMethod = .get) async -> Result<T, Error>
    {
        var baseUrl = EnviromentData.baseUrl
        baseUrl = addQuery(key: "aqi", value: airQuality ? "yes" : "no", to: baseUrl)
        querys.forEach { baseUrl = addQuery(key: $0, value: $1, to: baseUrl) }
        guard let url = URL(string: baseUrl) else { return .failure(BaseNetworkingError.cantCreateUrl) }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = httpMethod.rawValue

        do {
            let (data, response) = try await URLSession(configuration: .ephemeral).data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(BaseNetworkingError.noResponse)
            }

            switch response.statusCode {
            case 200 ... 299:
                let model: T = try JSONDecoder().decode(T.self, from: data)
                return .success(model)
            case 401:
                return .failure(BaseNetworkingError.unauthorized)
            default:
                return .failure(BaseNetworkingError.unexpectedStatusCode)
            }

        } catch {
            return .failure(error)
        }
    }

    private func addQuery(key: String, value: String, to url: String) -> String {
        let query = String(format: "&%@=%@", key, value)
        return url + query
    }
}
