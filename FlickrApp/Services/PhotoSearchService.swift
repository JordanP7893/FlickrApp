//
//  PhotoSearchService.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import Foundation

protocol PhotoSearchServiceProtocol {
    func fetchPopularPhotos() async throws -> PhotoResponse
    func fetchPhotosMatching(tags: String, matchingAll: Bool) async throws -> PhotoResponse
}

class PhotoSearchService: PhotoSearchServiceProtocol, ObservableObject {
    private let decoder: JSONDecoder
    private let flickrApi: FlickrApiServiceProtocol

    init(flickrApi: FlickrApiServiceProtocol) {
        decoder = JSONDecoder()

        self.flickrApi = flickrApi
    }

    func fetchPopularPhotos() async throws -> PhotoResponse {
        return try await fetchPhotos(withAdditionalQueryItems: [])
    }

    func fetchPhotosMatching(tags: String, matchingAll: Bool) async throws -> PhotoResponse {
        let additionalQueryItems = [
            URLQueryItem(name: "tags", value: tags),
            URLQueryItem(name: "tag_mode", value: matchingAll ? "all" : "any")
        ]

        return try await fetchPhotos(withAdditionalQueryItems: additionalQueryItems)
    }

    private func fetchPhotos(withAdditionalQueryItems additionalQueryItems: [URLQueryItem]) async throws -> PhotoResponse {
        var queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "sort", value: "interestingness-desc"),
            URLQueryItem(name: "has_geo", value: "1"),
            URLQueryItem(name: "extras", value: "url_m, owner_name, tags, geo, icon_server")
        ]
        queryItems.append(contentsOf: additionalQueryItems)

        let data = try await flickrApi.callFlickrApi(with: queryItems)
        return try decoder.decode(PhotoResponse.self, from: Data(data))
    }
}
