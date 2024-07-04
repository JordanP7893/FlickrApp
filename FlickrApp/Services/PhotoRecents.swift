//
//  PhotoRecents.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import Foundation

protocol PhotoRecentsServiceProtocol {
    func fetchRecents() async throws -> PhotoResponse
}

class PhotoRecents: PhotoRecentsServiceProtocol {
    private let decoder: JSONDecoder

    init() {
        decoder = JSONDecoder()
    }

    func fetchRecents() async throws -> PhotoResponse {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "www.flickr.com"
        components.path = "/services/rest/"
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "202c946c3bcf9cb1670d9a3ecc2d766f"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "has_geo", value: "1"),
            URLQueryItem(name: "sort", value: "interestingness-desc"),
            URLQueryItem(name: "extras", value: "url_m, owner_name, tags, geo")
        ]

        guard let url = components.url else { throw URLError(.badURL) }

        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }

        return try decoder.decode(PhotoResponse.self, from: Data(data))
    }
}

struct PhotoResponse: Decodable {
    struct PhotosContainer: Decodable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: Int
        let photo: [Photo]
    }

    let photos: PhotosContainer
}
