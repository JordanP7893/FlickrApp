//
//  PhotoSearchServiceTests.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 06/07/2024.
//

@testable import FlickrApp
import XCTest

final class PhotoSearchServiceTests: XCTestCase {
    var mockFlickrApiService: MockFlickrApiService!
    var photoSearchService: PhotoSearchService!

    override func setUp() {
        super.setUp()
        mockFlickrApiService = MockFlickrApiService()
        photoSearchService = PhotoSearchService(flickrApi: mockFlickrApiService)
    }

    override func tearDown() {
        mockFlickrApiService = nil
        photoSearchService = nil
        super.tearDown()
    }

    func test_givenFlickrApiServiceReturnsData_whenFetchPopularPhotosIsCalled_thenResponseIsSetToData() async {
        mockFlickrApiService.responseData = .dummy

        do {
            let response = try await photoSearchService.fetchPopularPhotos()

            XCTAssertNotNil(response)
            XCTAssertEqual(response.photos.photo.count, 1)
            XCTAssertEqual(response.photos.photo.first?.id, "12345")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func test_givenFlickrApiServiceThrowsAnError_whenFetchPopularPhotosIsCalled_thenErrorIsThrown() async {
        mockFlickrApiService.shouldReturnError = true

        do {
            let _ = try await photoSearchService.fetchPopularPhotos()
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
