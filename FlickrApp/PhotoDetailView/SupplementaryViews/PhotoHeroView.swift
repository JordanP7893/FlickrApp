//
//  PhotoHeroView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 04/07/2024.
//

import SwiftUI

struct PhotoHeroView: View {
    let photo: Photo

    var body: some View {
        if let url = photo.url {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(minHeight: 200)

                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask {
                        VStack(spacing: 0) {
                            LinearGradient(
                                colors: [
                                    Color.black.opacity(1),
                                    Color.black.opacity(0),
                                ],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            Rectangle()
                                .frame(height: 40)
                        }
                    }
                    .frame(height: 120)

                VStack(alignment: .leading) {
                    if let title = photo.title {
                        Text(title)
                            .font(.title2)
                            .bold()
                    }
                    Text(photo.owner)
                        .font(photo.title != nil ? .caption : .title2)
                        .italic()
                }
                .lineLimit(1)
                .foregroundStyle(.white)
                .padding(5)
                .shadow(radius: 10)
            }
        }
    }
}

#Preview {
    PhotoHeroView(photo: .dummy)
}
