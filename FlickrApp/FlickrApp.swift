//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    let recentPhotosService = PhotoRecents()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recentPhotosService)
        }
    }
}
