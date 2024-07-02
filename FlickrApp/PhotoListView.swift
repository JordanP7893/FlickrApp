//
//  PhotoListView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 02/07/2024.
//

import SwiftUI

struct PhotoListView: View {
    let columns = Array(repeating: GridItem(alignment: .top), count: 2)

    @State private var viewModel = ViewModel(photoRecentService: PhotoRecents())

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.photos) { photo in
                    if let url = photo.url {
                        PhotoCellView(
                            title: photo.title,
                            owner: photo.owner,
                            url: url
                        )
                    }
                }
            }
            ProgressView()
                .dynamicTypeSize(.large)
                .onAppear {
                    print("load more...")
                }
        }
        .task {
            await viewModel.fetchRecentPhotos()
        }
    }
}

#Preview {
    PhotoListView()
}
