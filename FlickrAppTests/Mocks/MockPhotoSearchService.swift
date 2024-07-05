//
//  MockPhotoSearchService.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 05/07/2024.
//

@testable import FlickrApp
import Foundation

class MockPhotoSearchService: PhotoSearchServiceProtocol {
    var fetchPopularPhotosResult: Result<PhotoResponse, Error>!

    func fetchPopularPhotos() async throws -> PhotoResponse {
        switch fetchPopularPhotosResult {
        case .success(let photoResponse): return photoResponse
        case .failure(let error): throw error
        case .none: fatalError("fetchPopularPhotosResult was not set in the mock")
        }
    }
}
