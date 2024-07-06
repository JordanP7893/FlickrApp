//
//  UserProfileViewViewModelTests.swift
//  FlickrAppTests
//
//  Created by Jordan Porter on 05/07/2024.
//

@testable import FlickrApp
import XCTest

final class UserProfileViewViewModelTests: XCTestCase {
    var viewModel: UserProfieView.ViewModel!
    var mockUserPhotosService: MockUserPhotosService!

    override func setUpWithError() throws {
        try super.setUpWithError()

        mockUserPhotosService = MockUserPhotosService()
        viewModel = UserProfieView.ViewModel(userId: "123", userPhotosService: mockUserPhotosService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockUserPhotosService = nil
        super.tearDown()
    }

    func test_givenFetchPopularPhotosReturnsData_whenFetchPopularPhototsIsCalled_thenStateIsSetToPhotosArray() async {
        mockUserPhotosService.fetchUsersPhotosResult = .success(.dummy)

        await viewModel.fetchUserPhotos()

        XCTAssertEqual(viewModel.state, .content(PhotoResponse.dummy.photos.photo))
    }

    func test_givenFetchPopularPhotosReturnsError_whenFetchPopularPhototsIsCalled_theStateIsSetToError() async {
        mockUserPhotosService.fetchUsersPhotosResult = .failure(URLError.init(.badURL))

        await viewModel.fetchUserPhotos()

        XCTAssertEqual(viewModel.state, .error(URLError(.badURL).localizedDescription))
    }
}
