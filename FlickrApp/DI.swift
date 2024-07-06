//
//  DI.swift
//  FlickrApp
//
//  Created by Jordan Porter on 06/07/2024.
//

import SwiftUI

struct DIModifier: ViewModifier {
    let photoSearchService = PhotoSearchService(flickrApi: FlickrApiService())
    let userPhotosService = UserPhotosService(flickrApi: FlickrApiService())

    func body(content: Content) -> some View {
        content
            .environmentObject(photoSearchService)
            .environmentObject(userPhotosService)
    }
}

extension View {
    func injectDependancies() -> some View {
        modifier(DIModifier())
    }
}
