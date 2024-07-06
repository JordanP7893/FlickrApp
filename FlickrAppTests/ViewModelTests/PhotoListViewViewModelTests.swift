//
//  PhotoListViewViewModelTests.swift.swift
//  PhotoListViewViewModelTests.swift
//
//  Created by Jordan Porter on 01/07/2024.
//

@testable import FlickrApp
import XCTest

final class PhotoListViewViewModelTests: XCTestCase {
    var viewModel: PhotoListView.ViewModel!
    var mockPhotoSearchService: MockPhotoSearchService!

    override func setUpWithError() throws {
        try super.setUpWithError()

        mockPhotoSearchService = MockPhotoSearchService()
        viewModel = PhotoListView.ViewModel(photoSearchService: mockPhotoSearchService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockPhotoSearchService = nil
        super.tearDown()
    }

    func test_givenFetchPopularPhotosReturnsData_whenFetchPopularPhototsIsCalled_photosVariableIsSet() async {
        mockPhotoSearchService.fetchPopularPhotosResult = .success(.dummy)

        await viewModel.fetchPopularPhotos()

        XCTAssertEqual(viewModel.state, .content(PhotoResponse.dummy.photos.photo))
    }

    func test_givenFetchPopularPhotosReturnsError_whenFetchPopularPhototsIsCalled_errorFlagIsSet() async {
        mockPhotoSearchService.fetchPopularPhotosResult = .failure(URLError.init(.badURL))

        await viewModel.fetchPopularPhotos()

        XCTAssertEqual(viewModel.state, .error(URLError(.badURL).localizedDescription))
    }
}
