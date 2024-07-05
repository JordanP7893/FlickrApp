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
        private(set) var photos: [Photo] = []
        private var userId: String

        let userPhotosService: UserPhotosServiceProtocol!

        init(userId: String, userPhotosService: UserPhotosServiceProtocol!) {
            self.userId = userId

            self.userPhotosService = userPhotosService
        }

        func fetchUserPhotos() async {
            do {
                let photoData = try await userPhotosService.fetchUsersPhotos(userId: userId)
                photos = photoData.photos.photo
            } catch {
                print(error)
            }
        }
    }
}
