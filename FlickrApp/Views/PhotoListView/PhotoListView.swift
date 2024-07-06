//
//  PhotoListView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import SwiftUI

struct PhotoListView: View {
    enum NavigationDestinations: Hashable {
        case photoDetail(Photo)
        case userProfile(Photo)
    }

    @EnvironmentObject var userPhotosService: UserPhotosService
    @State private var navigationPath = NavigationPath()
    @State private var viewModel: ViewModel

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                switch viewModel.state {
                case .content(let photos): PhotoGrid(navigationPath: $navigationPath, photos: photos)
                case .error(let error): errorView(errorMessage: error)
                case .loading: loadingView
                }
            }
            .task {
                await viewModel.loadInitalPhotos()
            }
            .refreshable {
                await viewModel.fetchPopularPhotos()
            }
            .navigationTitle("Photos")
            .navigationDestination(for: NavigationDestinations.self) { destination in
                switch destination {
                case .userProfile(let photo): UserProfieView(
                    ownerName: photo.owner,
                    buddyUrl: photo.buddyUrl,
                    viewModel: .init(
                        userId: photo.ownerId,
                        userPhotosService: userPhotosService
                    )
                )
                case .photoDetail(let photo): PhotoDetailView(photo: photo)
                }
            }
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    func errorView(errorMessage: String) -> some View {
        ZStack {
            Spacer()
                .containerRelativeFrame([.horizontal, .vertical])

            ContentUnavailableView(
                "Error",
                systemImage: "xmark.circle",
                description: Text("Pull down to refresh \n\n \(errorMessage)")
            )
        }
    }

    var loadingView: some View {
        ZStack {
            Spacer()
                .containerRelativeFrame([.horizontal, .vertical])

            ProgressView()
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

extension PhotoListView {
    struct PhotoGrid: View {
        @EnvironmentObject var userPhotosService: UserPhotosService
        @Binding var navigationPath: NavigationPath

        let columns = Array(repeating: GridItem(alignment: .top), count: 2)

        let photos: [Photo]

        var body: some View {
            LazyVGrid(columns: columns) {
                ForEach(photos) { photo in
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
                        .accessibilityElement(children: .combine)
                        .accessibilityAction(named: "User Profile") {
                            navigationPath.append(PhotoListView.NavigationDestinations.userProfile(photo))
                        }
                        .accessibilityAction(named: "Photo Detail") {
                            navigationPath.append(PhotoListView.NavigationDestinations.photoDetail(photo))
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
