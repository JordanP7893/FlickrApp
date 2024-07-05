//
//  UserProfieView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 05/07/2024.
//

import SwiftUI

struct UserProfieView: View {
    let columns = Array(repeating: GridItem(spacing: 1, alignment: .top), count: 3)

    let ownerName: String
    let buddyUrl: URL

    @State var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                AsyncImage(url: buddyUrl) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image("ProfilePlaceholder")
                        .resizable()
                }
                .frame(width: 96, height: 96)
                .clipShape(Circle())

                Spacer()

                Text(ownerName)
                    .font(.title2)
            }
            .padding()

            Divider()

            if viewModel.photos.isEmpty {
                ProgressView()
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 1) {
                        ForEach(viewModel.photos) { photo in
                            NavigationLink {
                                PhotoDetailView(photo: photo)
                            } label: {
                                Rectangle()
                                    .aspectRatio(1, contentMode: .fill)
                                    .overlay {
                                        AsyncImage(url: photo.url) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Rectangle()
                                                .foregroundStyle(.background)
                                                .aspectRatio(1, contentMode: .fill)
                                        }
                                    }
                                    .clipped()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchUserPhotos()
        }
    }
}

#Preview {
    class FakeUserPhotosService: UserPhotosServiceProtocol {
        func fetchUsersPhotos(userId: String) async throws -> PhotoResponse {
            return .dummy
        }
    }

    let userPhotosService = FakeUserPhotosService()

    return NavigationStack {
        UserProfieView(
            ownerName: "Jordan Porter",
            buddyUrl: URL(string: "http://farm4.staticflickr.com/3666/buddyicons/9619972@N08.jpg")!,
            viewModel: .init(userId: "123", userPhotosService: userPhotosService)
        )
    }
}
