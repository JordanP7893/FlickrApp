//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    let flickrApi = FlickrApiService()
    let photoSearchService = PhotoSearchService(flickrApi: FlickrApiService())
    let userPhotosService = UserPhotosService(flickrApi: FlickrApiService())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(photoSearchService)
                .environmentObject(userPhotosService)
        }
    }
}
