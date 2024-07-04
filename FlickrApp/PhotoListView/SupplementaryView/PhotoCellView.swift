//
//  PhotoCellView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import Foundation

import SwiftUI

struct PhotoCellView: View {
    let title: String
    let owner: String
    let url: URL

    var body: some View {
        VStack {
            PhotoImageView(url: url)

            VStack(alignment: .leading) {
                Text(owner)
                    .font(.caption)
                    .italic()
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct PhotoImageView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
        } placeholder: {
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                ProgressView()
            }
        }
    }
}

#Preview {
    PhotoCellView(
        title: "Wood Storks",
        owner: "walterjeffords",
        url: URL(string: "https://live.staticflickr.com/65535/53827544342_4beb3676a5.jpg")!
    )
        .frame(width: 200)
}
