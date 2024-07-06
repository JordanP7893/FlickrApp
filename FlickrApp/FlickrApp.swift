//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .injectDependancies()
        }
    }
}
