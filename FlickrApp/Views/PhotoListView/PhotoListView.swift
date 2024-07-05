//
//  PhotoListView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import SwiftUI

struct PhotoListView: View {
    let columns = Array(repeating: GridItem(alignment: .top), count: 2)

    @EnvironmentObject var userPhotosService: UserPhotosService
    @State private var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.photos) { photo in
                        if let url = photo.url {
                            VStack {
                                ZStack(alignment: .bottomTrailing) {
                                    NavigationLink {
                                        PhotoDetailView(photo: photo)
                                    } label: {
                                        PhotoCellView(
                                            owner: photo.owner,
                                            url: url
                                        )
                                    }
                                    .foregroundStyle(.primary)

                                    NavigationLink {
                                        UserProfieView(
                                            ownerName: photo.owner,
                                            buddyUrl: photo.buddyUrl,
                                            viewModel: .init(
                                                userId: photo.ownerId,
                                                userPhotosService: userPhotosService
                                            )
                                        )
                                    } label: {
                                        AsyncImage(url: photo.buddyUrl) { image in
                                            image
                                                .resizable()
                                        } placeholder: {
                                            Image("ProfilePlaceholder")
                                                .resizable()
                                        }
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .shadow(radius: 10, x: 2, y: 2)
                                    }
                                }

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
                await viewModel.fetchPopularPhotos()
            }
            .navigationTitle("Photos")
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    class FakePhotoSearchService: PhotoSearchServiceProtocol {
        func fetchPopularPhotos() async throws -> PhotoResponse {
            return .dummy
        }
    }

    let photoSearchService = FakePhotoSearchService()

    return PhotoListView(viewModel: .init(photoSearchService: photoSearchService))
        .environmentObject(UserPhotosService(flickrApi: FlickrApiService()))
}
