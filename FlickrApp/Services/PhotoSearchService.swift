//
//  PhotoSearchService.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import Foundation

protocol PhotoSearchServiceProtocol {
    func fetchPopularPhotos() async throws -> PhotoResponse
}

class PhotoSearchService: PhotoSearchServiceProtocol, ObservableObject {
    private let decoder: JSONDecoder
    private let flickrApi: FlickrApiServiceProtocol

    init(flickrApi: FlickrApiServiceProtocol) {
        decoder = JSONDecoder()

        self.flickrApi = flickrApi
    }

    func fetchPopularPhotos() async throws -> PhotoResponse {
        let queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "sort", value: "interestingness-desc"),
            URLQueryItem(name: "has_geo", value: "1"),
            URLQueryItem(name: "extras", value: "url_m, owner_name, tags, geo, icon_server")
        ]
        let data = try await flickrApi.callFlickrApi(with: queryItems)

        return try decoder.decode(PhotoResponse.self, from: Data(data))
    }
}
