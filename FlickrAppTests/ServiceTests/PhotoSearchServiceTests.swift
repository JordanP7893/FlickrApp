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

    func test_givenFlickrApiServiceReturnsData_whenFetchPhotosMatchingTagsIsCalled_thenResponseIsSetToData() async {
        mockFlickrApiService.responseData = .dummy

        do {
            let response = try await photoSearchService.fetchPhotosMatching(tags: "123", matchingAll: false)

            XCTAssert(mockFlickrApiService.queryItems!.contains(where: { $0.name == "tag_mode" && $0.value == "any" }))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.photos.photo.count, 1)
            XCTAssertEqual(response.photos.photo.first?.id, "12345")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func test_givenFlickrApiServiceReturnsData_whenFetchPhotosMatchingTagsAndMatchingAllIsCalled_thenResponseIsSetToData() async {
        mockFlickrApiService.responseData = .dummy

        do {
            let response = try await photoSearchService.fetchPhotosMatching(tags: "123", matchingAll: true)

            XCTAssert(mockFlickrApiService.queryItems!.contains(where: { $0.name == "tag_mode" && $0.value == "all" }))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.photos.photo.count, 1)
            XCTAssertEqual(response.photos.photo.first?.id, "12345")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func test_givenFlickrApiServiceThrowsAnError_whenFetchPhotosMatchingTagsIsCalled_thenErrorIsThrown() async {
        mockFlickrApiService.shouldReturnError = true

        do {
            let _ = try await photoSearchService.fetchPopularPhotos()
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
