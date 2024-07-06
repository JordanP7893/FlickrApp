//
//  MockPhotoSearchService.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 05/07/2024.
//

@testable import FlickrApp
import Foundation

class MockPhotoSearchService: PhotoSearchServiceProtocol {
    var serviceCallCount = 0
    var fetchPopularPhotosResult: Result<PhotoResponse, Error>!

    func fetchPopularPhotos() async throws -> PhotoResponse {
        serviceCallCount += 1
        switch fetchPopularPhotosResult {
        case .success(let photoResponse): return photoResponse
        case .failure(let error): throw error
        case .none: fatalError("fetchPopularPhotosResult was not set in the mock")
        }
    }
}
