//
//  PhotoListView+ViewModel.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import Foundation

extension PhotoListView {
    @Observable
    class ViewModel {
        private(set) var photos: [Photo] = []

        let photoSearchService: PhotoSearchServiceProtocol!

        init(photoSearchService: PhotoSearchServiceProtocol!) {
            self.photoSearchService = photoSearchService
        }

        func fetchPopularPhotos() async {
            do {
                let photoData = try await photoSearchService.fetchPopularPhotos()
                photos = photoData.photos.photo
            } catch {
                print(error)
            }
        }
    }
}
