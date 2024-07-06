//
//  UserPhotosServiceTests.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 06/07/2024.
//

@testable import FlickrApp
import XCTest

final class UserPhotosServiceTests: XCTestCase {
    var mockFlickrApiService: MockFlickrApiService!
    var userPhotosService: UserPhotosService!

    override func setUp() {
        super.setUp()
        mockFlickrApiService = MockFlickrApiService()
        userPhotosService = UserPhotosService(flickrApi: mockFlickrApiService)
    }

    override func tearDown() {
        mockFlickrApiService = nil
        userPhotosService = nil
        super.tearDown()
    }

    func test_givenFlickrApiServiceReturnsData_whenFetchUsersPhotosIsCalled_thenResponseIsSetToData() async {
        let userId = "67890"
        mockFlickrApiService.responseData = .dummy

        do {
            let response = try await userPhotosService.fetchUsersPhotos(userId: userId)

            XCTAssertNotNil(response)
            XCTAssertEqual(response.photos.photo.count, 1)
            XCTAssertEqual(response.photos.photo.first?.id, "12345")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func test_givenFlickrApiServiceThrowsAnError_whenFetchUsersPhotosIsCalled_thenErrorIsThrown() async {
        let userId = "67890"
        mockFlickrApiService.shouldReturnError = true

        do {
            let _ = try await userPhotosService.fetchUsersPhotos(userId: userId)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
