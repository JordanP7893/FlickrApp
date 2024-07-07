//
//  PhotoListView+ViewModel.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import SwiftUI

extension PhotoListView {
    @Observable
    class ViewModel {
        enum State: Equatable {
            case content([Photo])
            case error(String)
            case loading
        }

        private(set) var state: State = .loading
        var searchText: String = "" {
            didSet {
                if searchText.contains(" ") {
                    addSearchToken()
                }
            }
        }
        var matchingAllTags: Bool = false {
            didSet {
                triggerSearch()
            }
        }
        var tokens: [Token] = []

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

        func enterKeyPressed() {
            addSearchToken()
            triggerSearch()
        }

        private func addSearchToken() {
            let trimmedText = searchText.trimmingCharacters(in: .whitespaces)
            guard trimmedText != "" else { return }

            let words = trimmedText.split(separator: " ")

            for word in words {
                let newToken = Token(text: String(word))
                if !tokens.contains(newToken) {
                    withAnimation {
                        tokens.append(newToken)
                    }
                }
            }

            searchText = ""
        }

        private func triggerSearch() {
            state = .loading

            Task {
                do {
                    let tags = tokens.map { $0.text }.joined(separator: ",")
                    let photoData = try await photoSearchService.fetchPhotosMatching(tags: tags, matchingAll: matchingAllTags)
                    state = .content(photoData.photos.photo)
                } catch {
                    state = .error(error.localizedDescription)
                }
            }
        }
    }
}
