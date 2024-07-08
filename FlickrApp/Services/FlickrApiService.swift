//
//  FlickrApiService.swift
//  FlickrApp
//
//  Created by Jordan Porter on 05/07/2024.
//

import Foundation

protocol FlickrApiServiceProtocol {
    func callFlickrApi(with additionalQueryItems: [URLQueryItem]) async throws -> Data
}

class FlickrApiService: FlickrApiServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func callFlickrApi(with additionalQueryItems: [URLQueryItem]) async throws -> Data {
        var components = URLComponents()

        // Base url used for all requests
        components.scheme = "https"
        components.host = "www.flickr.com"
        components.path = "/services/rest/"

        // Base query items (api key and json format)
        var queryItems = [
            URLQueryItem(name: "api_key", value: "202c946c3bcf9cb1670d9a3ecc2d766f"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        queryItems.append(contentsOf: additionalQueryItems)
        components.queryItems = queryItems

        guard let url = components.url else { throw URLError(.badURL) }

        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"

        let (data, response) = try await session.data(for: request as URLRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }

        return data
    }
}
