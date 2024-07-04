//
//  PhotoDetailView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 04/07/2024.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            PhotoHeroView(photo: photo)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        PhotoDetailView(photo: .dummy)
    }
}
