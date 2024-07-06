//
//  ContentView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var photoSearchService: PhotoSearchService

    var body: some View {
        PhotoListView(
            viewModel: .init(
                photoSearchService: photoSearchService
            )
        )
    }
}

#Preview {
    let flickrApi = FlickrApiService()
    let photoSearchService = PhotoSearchService(flickrApi: FlickrApiService())
    let userPhotosService = UserPhotosService(flickrApi: FlickrApiService())

    return ContentView()
        .environmentObject(photoSearchService)
        .environmentObject(userPhotosService)
}
