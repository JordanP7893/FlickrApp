//
//  UserPhotosService.swift
//  FlickrApp
//
//  Created by Jordan Porter on 05/07/2024.
//

import Foundation

protocol UserPhotosServiceProtocol {
    func fetchUsersPhotos(userId: String) async throws -> PhotoResponse
}

class UserPhotosService: UserPhotosServiceProtocol, ObservableObject {
    private let decoder: JSONDecoder
    private let flickrApi: FlickrApiServiceProtocol

    init(flickrApi: FlickrApiServiceProtocol) {
        decoder = JSONDecoder()

        self.flickrApi = flickrApi
    }

    func fetchUsersPhotos(userId: String) async throws -> PhotoResponse {
        let queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "sort", value: "date-posted-desc"),
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "extras", value: "url_m, owner_name, tags, geo, icon_server")
        ]
        let data = try await flickrApi.callFlickrApi(with: queryItems)

        return try decoder.decode(PhotoResponse.self, from: Data(data))
    }
}
