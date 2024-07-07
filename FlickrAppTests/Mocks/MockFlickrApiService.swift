//
//  MockFlickrApiService.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 06/07/2024.
//

import Foundation
import XCTest

@testable import FlickrApp

class MockFlickrApiService: FlickrApiServiceProtocol {
    var shouldReturnError = false
    var responseData: Data?
    var queryItems: [URLQueryItem]?

    func callFlickrApi(with queryItems: [URLQueryItem]) async throws -> Data {
        self.queryItems = queryItems
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }

        guard let data = responseData else {
            fatalError("fetchUsersPhotosResult was not set in the mock")
        }

        return data
    }
}

extension Data {
    static var dummy: Self {
        let jsonString = """
        {
            "photos": {
                "page": 1,
                "pages": 1,
                "perpage": 100,
                "total": 1,
                "photo": [
                    {
                        "id": "12345",
                        "owner": "67890",
                        "secret": "secret",
                        "server": "server",
                        "iconfarm": 1,
                        "title": "title",
                        "ispublic": 1,
                        "isfriend": 0,
                        "isfamily": 0,
                        "url_m": "https://example.com/photo.jpg",
                        "ownername": "ownername",
                        "tags": "tag1 tag2",
                        "latitude": 0.0,
                        "longitude": 0.0,
                        "iconserver": "iconserver"
                    }
                ]
            },
            "stat": "ok"
        }
        """

        return jsonString.data(using: .utf8)!
    }
}
