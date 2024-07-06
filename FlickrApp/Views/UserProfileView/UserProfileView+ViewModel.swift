//
//  UserProfileView+ViewModel.swift
//  FlickrApp
//
//  Created by Jordan Porter on 05/07/2024.
//

import Foundation

extension UserProfieView {
    @Observable
    class ViewModel {
        private(set) var state: State = .loading
        private var userId: String

        enum State: Equatable {
            case content([Photo])
            case error(String)
            case loading
        }

        let userPhotosService: UserPhotosServiceProtocol!

        init(userId: String, userPhotosService: UserPhotosServiceProtocol!) {
            self.userId = userId

            self.userPhotosService = userPhotosService
        }

        func fetchUserPhotos() async {
            do {
                let photoData = try await userPhotosService.fetchUsersPhotos(userId: userId)
                state = .content(photoData.photos.photo)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
