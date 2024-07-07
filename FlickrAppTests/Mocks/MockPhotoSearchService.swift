//
//  MockPhotoSearchService.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 05/07/2024.
//

@testable import FlickrApp
import Foundation

class MockPhotoSearchService: PhotoSearchServiceProtocol {
    var fetchPopularPhotosServiceCallCount = 0
    var fetchPopularPhotosResult: Result<PhotoResponse, Error>!

    func fetchPopularPhotos() async throws -> PhotoResponse {
        fetchPopularPhotosServiceCallCount += 1
        switch fetchPopularPhotosResult {
        case .success(let photoResponse): return photoResponse
        case .failure(let error): throw error
        case .none: fatalError("fetchPopularPhotosResult was not set in the mock")
        }
    }

    var fetchPhotosMatchingTagsServiceCallCount = 0
    var fetchPhotosMatchingTagsResult: Result<PhotoResponse, Error>!

    func fetchPhotosMatching(tags: String, matchingAll: Bool) async throws -> PhotoResponse {
        fetchPhotosMatchingTagsServiceCallCount += 1
        switch fetchPhotosMatchingTagsResult {
        case .success(let photoResponse): return photoResponse
        case .failure(let error): throw error
        case .none: fatalError("fetchPopularPhotosResult was not set in the mock")
        }
    }
}
