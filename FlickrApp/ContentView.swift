//
//  ContentView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var photoRecentService: PhotoRecents

    var body: some View {
        PhotoListView(
            viewModel: .init(
                photoRecentService: photoRecentService
            )
        )
    }
}

#Preview {
    ContentView()
}
