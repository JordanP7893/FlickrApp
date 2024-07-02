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

        static let PhotoRecent = PhotoRecents()

        func fetchRecentPhotos() async {
            do {
                let photoData = try await PhotoRecents().fetchRecents()
                photos = photoData.photos.photo
            } catch {
                print(error)
            }
        }
    }
}
