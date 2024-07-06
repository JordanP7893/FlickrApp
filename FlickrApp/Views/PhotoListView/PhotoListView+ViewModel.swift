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
        private(set) var state: State = .loading

        enum State: Equatable {
            case content([Photo])
            case error(String)
            case loading
        }

        let photoSearchService: PhotoSearchServiceProtocol!

        init(photoSearchService: PhotoSearchServiceProtocol!) {
            self.photoSearchService = photoSearchService
        }

        func loadInitalPhotos() async {
            if case let .content(photos) = state, !photos.isEmpty { return }

            await fetchPopularPhotos()
        }

        func fetchPopularPhotos() async {
            do {
                let photoData = try await photoSearchService.fetchPopularPhotos()
                state = .content(photoData.photos.photo)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
