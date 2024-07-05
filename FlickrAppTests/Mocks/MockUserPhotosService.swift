//
//  MockUserPhotosService.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 05/07/2024.
//

@testable import FlickrApp
import Foundation

class MockUserPhotosService: UserPhotosServiceProtocol {
    var fetchUsersPhotosResult: Result<PhotoResponse, Error>!

    func fetchUsersPhotos(userId: String) async throws -> PhotoResponse {
        switch fetchUsersPhotosResult {
        case .success(let photoResponse): return photoResponse
        case .failure(let error): throw error
        case .none: fatalError("fetchUsersPhotosResult was not set in the mock")
        }
    }
}
