//
//  PhotoListView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import SwiftUI

struct PhotoListView: View {
    let columns = Array(repeating: GridItem(alignment: .top), count: 2)

    @State private var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.photos) { photo in
                        if let url = photo.url {
                            VStack {
                                NavigationLink {
                                    PhotoDetailView(photo: photo)
                                } label: {
                                    PhotoCellView(
                                        owner: photo.owner,
                                        url: url
                                    )
                                }
                                .foregroundStyle(.primary)

                                if let tags = photo.tags {
                                    PhotoTagsView(tags: tags)
                                }
                            }
                        }
                    }
                }
                .padding()

                ProgressView()
                    .onAppear {
                        print("load more...")
                    }
            }
            .task {
                await viewModel.fetchRecentPhotos()
            }
            .navigationTitle("Photos")
            .tint(.accent)
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    class FakePhotoRecentsService: PhotoRecentsServiceProtocol {
        func fetchRecents() async throws -> PhotoResponse {
            return .init(photos: .init(page: 1, pages: 1, perpage: 1, total: 1, photo: .dummyData))
        }
    }

    let photoRecentsService = FakePhotoRecentsService()

    return PhotoListView(viewModel: .init(photoRecentService: photoRecentsService))
}
