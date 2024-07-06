//
//  PhotoCellView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import Foundation

import SwiftUI

struct PhotoCellView: View {
    let owner: String
    let url: URL

    var body: some View {
        VStack {
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

            Text(owner)
                .font(.caption)
                .italic()
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityLabel("taken by \(owner)")
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    PhotoCellView(
        owner: "walterjeffords",
        url: URL(string: "https://live.staticflickr.com/65535/53827544342_4beb3676a5.jpg")!
    )
        .frame(width: 200)
}
