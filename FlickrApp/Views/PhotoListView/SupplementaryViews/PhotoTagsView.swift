//
//  PhotoTagsView.swift
//  FlickrApp
//
//  Created by Jordan Porter on 03/07/2024.
//

import SwiftUI

struct PhotoTagsView: View {
    let rows = [GridItem(.flexible(minimum: 1, maximum: 100))]

    let tags: [String]
    let font: Font

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { text in
                    Text(text)
                        .font(font)
                        .padding(4)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
    }

    init(tags: [String], font: Font = .footnote) {
        self.tags = tags
        self.font = font
    }
}

#Preview {
    PhotoTagsView(tags: ["birds", "storks", "water", "nature"])
}
